#!/usr/bin/env ruby
# typed: strict
# frozen_string_literal: true

require "digest"
require "json"
require "net/http"
require "open3"
require "optparse"
require "uri"

module PgstyInfra
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

  # Describes every release and asset-name contract managed by the tap.
  module Catalog
    module_function

    TIMESTAMP_TAG = /\ARELEASE\.\d{4}-\d{2}-\d{2}T\d{2}-\d{2}-\d{2}Z\z/
    SEMVER_TAG = /\Av\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?\z/
    PLAIN_SEMVER_TAG = /\A\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?\z/

    def timestamp_version(tag)
      tag.delete_prefix("RELEASE.")
    end

    def semver_version(tag)
      tag.delete_prefix("v")
    end

    def plain_version(tag)
      tag
    end

    def timestamp_asset(binary)
      lambda do |tag, platform|
        timestamp = tag.scan(/\d/).join
        raise Error, "invalid timestamp release tag: #{tag}" if timestamp.length != 14

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
          name:             "silo",
          repo:             "pgsty/silo",
          tag_pattern:      TIMESTAMP_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: true,
          version_proc:     method(:timestamp_version),
          asset_proc:       timestamp_asset("silo"),
        ),
        FormulaConfig.new(
          name:             "mcli",
          repo:             "pgsty/mc",
          tag_pattern:      TIMESTAMP_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: true,
          version_proc:     method(:timestamp_version),
          asset_proc:       timestamp_asset("mcli"),
        ),
        FormulaConfig.new(
          name:             "silo-console",
          repo:             "pgsty/silo-console",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          true,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |_tag, platform|
            "silo-console-#{platform.os}-#{platform.arch}"
          end,
        ),
        FormulaConfig.new(
          name:             "pig",
          repo:             "pgsty/pig",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "pig-#{tag}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "sow",
          repo:             "pgsty/sow",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       semver_asset("sow"),
        ),
        FormulaConfig.new(
          name:             "farrow",
          repo:             "pgsty/farrow",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: true,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       semver_asset("farrow"),
        ),
        FormulaConfig.new(
          name:             "pg-exporter",
          repo:             "pgsty/pg_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            version = semver_version(tag)
            "pg_exporter-#{version}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "agentsview",
          repo:             "kenn-io/agentsview",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "agentsview_#{semver_version(tag)}_#{platform.os}_#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "alertmanager",
          repo:             "prometheus/alertmanager",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "alertmanager-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "blackbox-exporter",
          repo:             "prometheus/blackbox_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "blackbox_exporter-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "headscale",
          repo:             "juanfont/headscale",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          true,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "headscale_#{semver_version(tag)}_#{platform.os}_#{platform.arch}"
          end,
        ),
        FormulaConfig.new(
          name:             "kafka-exporter",
          repo:             "danielqsj/kafka_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "kafka_exporter-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "loki-canary",
          repo:             "grafana/loki",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |_tag, platform|
            "loki-canary-#{platform.os}-#{platform.arch}.zip"
          end,
        ),
        FormulaConfig.new(
          name:             "mongodb-exporter",
          repo:             "percona/mongodb_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "mongodb_exporter-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "mtail",
          repo:             "jaqx0r/mtail",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "mtail_#{semver_version(tag)}_#{platform.os}_#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "mysqld-exporter",
          repo:             "prometheus/mysqld_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "mysqld_exporter-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "nginx-exporter",
          repo:             "nginx/nginx-prometheus-exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "nginx-prometheus-exporter_#{semver_version(tag)}_#{platform.os}_#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "pgbackrest-exporter",
          repo:             "woblerr/pgbackrest_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            os = (platform.os == "darwin") ? "macos" : "linux"
            arch = (platform.arch == "amd64") ? "x86_64" : "arm64"
            "pgbackrest_exporter-#{semver_version(tag)}-#{os}-#{arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "pgschema",
          repo:             "pgplex/pgschema",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          true,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "pgschema-#{semver_version(tag)}-#{platform.os}-#{platform.arch}"
          end,
        ),
        FormulaConfig.new(
          name:             "pg-timetable",
          repo:             "cybertec-postgresql/pg_timetable",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |_tag, platform|
            os = (platform.os == "darwin") ? "Darwin" : "Linux"
            arch = (platform.arch == "amd64") ? "x86_64" : "arm64"
            "pg_timetable_#{os}_#{arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "pushgateway",
          repo:             "prometheus/pushgateway",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "pushgateway-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "redis-exporter",
          repo:             "oliver006/redis_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "redis_exporter-v#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "sabiql",
          repo:             "riii111/sabiql",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |_tag, platform|
            os = (platform.os == "darwin") ? "apple-darwin" : "unknown-linux-gnu"
            arch = (platform.arch == "amd64") ? "x86_64" : "aarch64"
            "sabiql-#{arch}-#{os}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "sql-studio",
          repo:             "frectonz/sql-studio",
          tag_pattern:      PLAIN_SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:plain_version),
          asset_proc:       lambda do |_tag, platform|
            os = (platform.os == "darwin") ? "apple-darwin" : "unknown-linux-gnu"
            arch = (platform.arch == "amd64") ? "x86_64" : "aarch64"
            "sql-studio-#{arch}-#{os}.tar.xz"
          end,
        ),
        FormulaConfig.new(
          name:             "stalwart",
          repo:             "stalwartlabs/stalwart",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |_tag, platform|
            os = (platform.os == "darwin") ? "apple-darwin" : "unknown-linux-gnu"
            arch = (platform.arch == "amd64") ? "x86_64" : "aarch64"
            "stalwart-#{arch}-#{os}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "victoria-traces",
          repo:             "VictoriaMetrics/VictoriaTraces",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "victoria-traces-#{platform.os}-#{platform.arch}-v#{semver_version(tag)}.tar.gz"
          end,
        ),
        FormulaConfig.new(
          name:             "zfs-exporter",
          repo:             "waitingsong/zfs_exporter",
          tag_pattern:      SEMVER_TAG,
          allow_prerelease: false,
          nounzip:          false,
          explicit_version: false,
          version_proc:     method(:semver_version),
          asset_proc:       lambda do |tag, platform|
            "zfs_exporter-#{semver_version(tag)}.#{platform.os}-#{platform.arch}.tar.gz"
          end,
        ),
      ].freeze
    end
  end

  # Reads release metadata and verified digests from the GitHub API.
  class GitHubClient
    API_ROOT = "https://api.github.com"
    USER_AGENT = "pgsty-infra-updater/1"

    def initialize(token: ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"] || ENV.fetch("HOMEBREW_GITHUB_API_TOKEN", nil))
      @token = token || authenticated_gh_token
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

    def sha256(asset, existing_url:, existing_sha:)
      digest = asset["digest"].to_s
      match = /\Asha256:([0-9a-f]{64})\z/.match(digest)
      return match[1] if match

      url = asset.fetch("browser_download_url")
      valid_existing_sha = /\A[0-9a-f]{64}\z/.match?(existing_sha) && existing_sha != "0" * 64
      if url == existing_url && valid_existing_sha
        return existing_sha
      end

      warn "GitHub did not provide a digest for #{asset.fetch("name")}; hashing the asset download"
      digestor = Digest::SHA256.new
      download_sha256(URI(url), digestor: digestor)
    end

    private

    def authenticated_gh_token
      prefix_gh = File.join(ENV.fetch("HOMEBREW_PREFIX", ""), "bin", "gh")
      gh = File.executable?(prefix_gh) ? prefix_gh : "gh"
      stdout, _stderr, status = Open3.capture3(gh, "auth", "token")
      return unless status.success?

      token = stdout.strip
      token unless token.empty?
    rescue Errno::ENOENT
      nil
    end

    def download_sha256(uri, digestor:, redirects: 5)
      trusted_download_uri!(uri)
      raise Error, "too many redirects while downloading #{uri}" if redirects.negative?

      request = Net::HTTP::Get.new(uri)
      request["User-Agent"] = USER_AGENT
      http = Net::HTTP::Proxy(:ENV).new(uri.host, uri.port)
      http.use_ssl = true
      http.open_timeout = 15
      http.read_timeout = 120

      http.request(request) do |response|
        if response.is_a?(Net::HTTPRedirection)
          location = response.fetch("location")
          return download_sha256(URI.join(uri, location), digestor: digestor, redirects: redirects - 1)
        end
        unless response.is_a?(Net::HTTPSuccess)
          raise Error, "release asset download failed for #{uri}: HTTP #{response.code}"
        end

        response.read_body { |chunk| digestor.update(chunk) }
      end
      digestor.hexdigest
    end

    def trusted_download_uri!(uri)
      trusted_host = uri.host == "github.com" || uri.host.to_s.end_with?(".githubusercontent.com")
      return if uri.scheme == "https" && trusted_host

      raise Error, "refusing untrusted release asset URL: #{uri}"
    end

    def get_json(uri)
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["User-Agent"] = USER_AGENT
      request["X-GitHub-Api-Version"] = "2022-11-28"
      request["Authorization"] = "Bearer #{@token}" unless @token.to_s.empty?

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

  # Atomically renders all platform URL/SHA pairs in one Formula.
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
        if version_indexes.length != 1
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
        if matches.length != 1
          raise Error, "#{config.repo} #{tag} must provide exactly one #{asset_name} asset"
        end

        asset = matches.first
        url = asset.fetch("browser_download_url")
        validate_asset_url!(config, url)
        existing_url, existing_sha = platform_values(lines, path, platform)
        sha256 = @client.sha256(asset, existing_url: existing_url, existing_sha: existing_sha)
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
      safe_characters = url.index('"').nil? && url.index("\\").nil?
      return if url.start_with?(prefix) && safe_characters

      raise Error, "unexpected release asset URL for #{config.repo}: #{url}"
    end

    def replace_platform!(lines, path, platform, url, sha256, nounzip)
      marker_index, url_match, = platform_block(lines, path, platform)
      url_index = marker_index + 1
      sha_index = marker_index + 2
      suffix = nounzip ? ", using: :nounzip" : ""
      indent = url_match[1]
      lines[url_index] = "#{indent}url \"#{url}\"#{suffix}\n"
      lines[sha_index] = "#{indent}sha256 \"#{sha256}\"\n"
    end

    def platform_values(lines, path, platform)
      _marker_index, url_match, sha_match = platform_block(lines, path, platform)
      [url_match[2], sha_match[2]]
    end

    def platform_block(lines, path, platform)
      marker = "# update: #{platform.key}"
      indexes = lines.each_index.select { |index| lines[index].strip == marker }
      raise Error, "#{path} must contain exactly one #{marker} marker" if indexes.length != 1

      marker_index = indexes.first
      url_index = marker_index + 1
      sha_index = marker_index + 2
      url_match = /\A(\s*)url "([^"]+)"(?:, using: :nounzip)?\s*\z/.match(lines.fetch(url_index))
      sha_match = /\A(\s*)sha256 "([0-9a-f]{64})"\s*\z/.match(lines.fetch(sha_index))
      valid_block = url_match && sha_match && url_match[1] == sha_match[1]
      unless valid_block
        raise Error, "#{path} has an invalid URL/SHA block after #{marker}"
      end

      [marker_index, url_match, sha_match]
    end
  end

  # Parses updater CLI options and defers all writes until every release validates.
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
        raise Error, "unknown formula: #{unknown.join(", ")}" unless unknown.empty?

        configs = configs.select { |config| @options[:formulae].include?(config.name) }
      end

      updater = FormulaUpdater.new(root: @root, client: GitHubClient.new)
      rendered = configs.map { |config| updater.render(config) }
      changed = rendered.reject { |path, content, _tag| File.read(path) == content }

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
      raise Error, "unexpected arguments: #{argv.join(" ")}" unless argv.empty?
    rescue OptionParser::ParseError => e
      raise Error, e.message
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    exit PgstyInfra::Runner.new(ARGV).run
  rescue PgstyInfra::Error, JSON::ParserError, KeyError, SystemCallError, Timeout::Error => e
    warn "update-formulae: #{e.message}"
    exit 1
  end
end
