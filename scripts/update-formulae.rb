#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "json"
require "net/http"
require "open-uri"
require "optparse"
require "uri"

module PgstyTap
  class Error < StandardError; end

  Platform = Struct.new(:key, :os, :arch, keyword_init: true)
  FormulaConfig = Struct.new(
    :name,
    :repo,
    :tag_pattern,
    :allow_prerelease,
    :nounzip,
    :explicit_version,
    :version_proc,
    :asset_proc,
    keyword_init: true,
  ) do
    def version_for(tag)
      version_proc.call(tag)
    end

    def asset_name(tag, platform)
      asset_proc.call(tag, platform)
    end
  end

  PLATFORMS = [
    Platform.new(key: "darwin_arm64", os: "darwin", arch: "arm64"),
    Platform.new(key: "darwin_amd64", os: "darwin", arch: "amd64"),
    Platform.new(key: "linux_arm64", os: "linux", arch: "arm64"),
    Platform.new(key: "linux_amd64", os: "linux", arch: "amd64"),
  ].freeze

  module Catalog
    module_function

    TIMESTAMP_TAG = /\ARELEASE\.\d{4}-\d{2}-\d{2}T\d{2}-\d{2}-\d{2}Z\z/
    SEMVER_TAG = /\Av\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?\z/

    def timestamp_version(tag)
      tag.delete_prefix("RELEASE.")
    end

    def semver_version(tag)
      tag.delete_prefix("v")
    end

    def timestamp_asset(binary)
      lambda do |tag, platform|
        timestamp = tag.scan(/\d/).join
        raise Error, "invalid timestamp release tag: #{tag}" unless timestamp.length == 14

        "#{binary}_#{timestamp}.0.0_#{platform.os}_#{platform.arch}.tar.gz"
      end
    end

    def semver_asset(binary, separator: "_", version_prefix: "")
      lambda do |tag, platform|
        version = semver_version(tag)
        "#{binary}#{separator}#{version_prefix}#{version}#{separator}#{platform.os}#{separator}#{platform.arch}.tar.gz"
      end
    end

    def configs
      @configs ||= [
        FormulaConfig.new(
          name: "silo",
          repo: "pgsty/silo",
          tag_pattern: TIMESTAMP_TAG,
          allow_prerelease: false,
          nounzip: false,
          explicit_version: true,
          version_proc: method(:timestamp_version),
          asset_proc: timestamp_asset("silo"),
        ),
        FormulaConfig.new(
          name: "mcli",
          repo: "pgsty/mc",
          tag_pattern: TIMESTAMP_TAG,
          allow_prerelease: false,
          nounzip: false,
          explicit_version: true,
          version_proc: method(:timestamp_version),
          asset_proc: timestamp_asset("mcli"),
        ),
        FormulaConfig.new(
          name: "silo-console",
          repo: "pgsty/silo-console",
          tag_pattern: SEMVER_TAG,
          allow_prerelease: false,
          nounzip: true,
          explicit_version: false,
          version_proc: method(:semver_version),
          asset_proc: lambda do |_tag, platform|
            "silo-console-#{platform.os}-#{platform.arch}"
          end,
        ),
        FormulaConfig.new(
          name: "pig",
          repo: "pgsty/pig",
          tag_pattern: SEMVER_TAG,
          allow_prerelease: false,
          nounzip: false,
          explicit_version: false,
          version_proc: method(:semver_version),
          asset_proc: lambda do |tag, platform|
            "pig-#{tag}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name: "sow",
          repo: "pgsty/sow",
          tag_pattern: SEMVER_TAG,
          allow_prerelease: false,
          nounzip: false,
          explicit_version: false,
          version_proc: method(:semver_version),
          asset_proc: semver_asset("sow"),
        ),
        FormulaConfig.new(
          name: "farrow",
          repo: "pgsty/farrow",
          tag_pattern: SEMVER_TAG,
          allow_prerelease: true,
          nounzip: false,
          explicit_version: false,
          version_proc: method(:semver_version),
          asset_proc: semver_asset("farrow"),
        ),
        FormulaConfig.new(
          name: "pg-exporter",
          repo: "pgsty/pg_exporter",
          tag_pattern: SEMVER_TAG,
          allow_prerelease: false,
          nounzip: false,
          explicit_version: false,
          version_proc: method(:semver_version),
          asset_proc: lambda do |tag, platform|
            version = semver_version(tag)
            "pg_exporter-#{version}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
      ].freeze
    end
  end

  class GitHubClient
    API_ROOT = "https://api.github.com"
    USER_AGENT = "pgsty-homebrew-tap-updater/1"

    def initialize(token: ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"])
      @token = token
    end

    def latest_release(config)
      uri = URI("#{API_ROOT}/repos/#{config.repo}/releases?per_page=100")
      releases = get_json(uri)
      raise Error, "GitHub returned a non-array release list for #{config.repo}" unless releases.is_a?(Array)

      release = releases.find do |candidate|
        next false if candidate["draft"]
        next false if candidate["prerelease"] && !config.allow_prerelease

        tag = candidate["tag_name"].to_s
        config.tag_pattern.match?(tag)
      end
      raise Error, "no eligible release found for #{config.repo}" unless release

      release
    end

    def sha256(asset)
      digest = asset["digest"].to_s
      match = /\Asha256:([0-9a-f]{64})\z/.match(digest)
      return match[1] if match

      url = asset.fetch("browser_download_url")
      warn "GitHub did not provide a digest for #{asset.fetch('name')}; hashing the asset download"
      digestor = Digest::SHA256.new
      URI.open(url, "User-Agent" => USER_AGENT) do |io|
        while (chunk = io.read(1024 * 1024))
          digestor.update(chunk)
        end
      end
      digestor.hexdigest
    end

    private

    def get_json(uri)
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["User-Agent"] = USER_AGENT
      request["X-GitHub-Api-Version"] = "2022-11-28"
      request["Authorization"] = "Bearer #{@token}" if @token && !@token.empty?

      http = Net::HTTP::Proxy(:ENV).new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 15
      http.read_timeout = 60
      response = http.request(request)
      unless response.is_a?(Net::HTTPSuccess)
        raise Error, "GitHub API request failed for #{uri}: HTTP #{response.code}"
      end

      JSON.parse(response.body)
    end
  end

  class FormulaUpdater
    VERSION_LINE = /^  version "[^"]+"$/

    def initialize(root:, client:)
      @root = root
      @client = client
    end

    def render(config)
      release = @client.latest_release(config)
      tag = release.fetch("tag_name")
      version = config.version_for(tag)
      validate_version!(version)

      path = File.join(@root, "Formula", "#{config.name}.rb")
      source = File.read(path)
      lines = source.lines
      version_indexes = lines.each_index.select { |index| VERSION_LINE.match?(lines[index].chomp) }
      if config.explicit_version
        unless version_indexes.length == 1
          raise Error, "#{path} must contain exactly one two-space-indented version line"
        end
        lines[version_indexes.first] = "  version \"#{version}\"\n"
      elsif !version_indexes.empty?
        raise Error, "#{path} must let Homebrew infer its version from the release URL"
      end

      assets = release.fetch("assets").group_by { |asset| asset.fetch("name") }
      PLATFORMS.each do |platform|
        asset_name = config.asset_name(tag, platform)
        matches = assets.fetch(asset_name, [])
        unless matches.length == 1
          raise Error, "#{config.repo} #{tag} must provide exactly one #{asset_name} asset"
        end

        asset = matches.first
        url = asset.fetch("browser_download_url")
        validate_asset_url!(config, url)
        sha256 = @client.sha256(asset)
        replace_platform!(lines, path, platform, url, sha256, config.nounzip)
      end

      [path, lines.join, tag]
    end

    private

    def validate_version!(version)
      return if /\A[0-9A-Za-z.+TZ-]+\z/.match?(version)

      raise Error, "unsafe formula version: #{version.inspect}"
    end

    def validate_asset_url!(config, url)
      prefix = "https://github.com/#{config.repo}/releases/download/"
      return if url.start_with?(prefix) && !url.include?('"') && !url.include?("\\")

      raise Error, "unexpected release asset URL for #{config.repo}: #{url}"
    end

    def replace_platform!(lines, path, platform, url, sha256, nounzip)
      marker = "# update: #{platform.key}"
      indexes = lines.each_index.select { |index| lines[index].strip == marker }
      raise Error, "#{path} must contain exactly one #{marker} marker" unless indexes.length == 1

      marker_index = indexes.first
      url_index = marker_index + 1
      sha_index = marker_index + 2
      url_match = /\A(\s*)url "[^"]+"(?:, using: :nounzip)?\s*\z/.match(lines.fetch(url_index))
      sha_match = /\A(\s*)sha256 "[0-9a-f]{64}"\s*\z/.match(lines.fetch(sha_index))
      unless url_match && sha_match && url_match[1] == sha_match[1]
        raise Error, "#{path} has an invalid URL/SHA block after #{marker}"
      end

      suffix = nounzip ? ", using: :nounzip" : ""
      indent = url_match[1]
      lines[url_index] = "#{indent}url \"#{url}\"#{suffix}\n"
      lines[sha_index] = "#{indent}sha256 \"#{sha256}\"\n"
    end
  end

  class Runner
    def initialize(argv, root: File.expand_path("..", __dir__))
      @root = root
      @options = { check: false, formulae: [] }
      parse!(argv)
    end

    def run
      configs = Catalog.configs
      unless @options[:formulae].empty?
        unknown = @options[:formulae] - configs.map(&:name)
        raise Error, "unknown formula: #{unknown.join(', ')}" unless unknown.empty?

        configs = configs.select { |config| @options[:formulae].include?(config.name) }
      end

      updater = FormulaUpdater.new(root: @root, client: GitHubClient.new)
      rendered = configs.map { |config| updater.render(config) }
      changed = rendered.select { |path, content, _tag| File.read(path) != content }

      if @options[:check]
        changed.each { |path, _content, tag| warn "outdated: #{File.basename(path)} (latest #{tag})" }
        return changed.empty? ? 0 : 1
      end

      rendered.each do |path, content, tag|
        if File.read(path) == content
          puts "current: #{File.basename(path)} (#{tag})"
        else
          File.write(path, content)
          puts "updated: #{File.basename(path)} (#{tag})"
        end
      end
      0
    end

    private

    def parse!(argv)
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options]"
        opts.on("--check", "Exit non-zero when a formula is not current") { @options[:check] = true }
        opts.on("--formula NAME", "Update/check one formula (repeatable)") do |name|
          @options[:formulae] << name
        end
      end
      parser.parse!(argv)
      raise Error, "unexpected arguments: #{argv.join(' ')}" unless argv.empty?
    rescue OptionParser::ParseError => e
      raise Error, e.message
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    exit PgstyTap::Runner.new(ARGV).run
  rescue PgstyTap::Error, JSON::ParserError, KeyError, OpenURI::HTTPError, SystemCallError => e
    warn "update-formulae: #{e.message}"
    exit 1
  end
end
