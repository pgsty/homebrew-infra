# frozen_string_literal: true

require "minitest/autorun"
require_relative "../scripts/update-formulae"

class UpdateFormulaeTest < Minitest::Test
  def configs
    PgstyTap::Catalog.configs.to_h { |config| [config.name, config] }
  end

  def platform(key)
    PgstyTap::PLATFORMS.find { |candidate| candidate.key == key }
  end

  def test_catalog_contains_the_public_formula_set
    assert_equal %w[farrow mcli pg-exporter pig silo silo-console sow], configs.keys.sort
  end

  def test_timestamp_release_mapping
    silo = configs.fetch("silo")
    tag = "RELEASE.2026-08-06T00-00-00Z"

    assert_equal "2026-08-06T00-00-00Z", silo.version_for(tag)
    assert_equal "silo_20260806000000.0.0_darwin_arm64.tar.gz",
                 silo.asset_name(tag, platform("darwin_arm64"))
  end

  def test_semver_release_mapping
    pig = configs.fetch("pig")
    tag = "v1.8.0"

    assert_equal "1.8.0", pig.version_for(tag)
    assert_equal "pig-v1.8.0.linux-amd64.tar.gz", pig.asset_name(tag, platform("linux_amd64"))
  end

  def test_raw_console_assets_are_marked_nounzip
    console = configs.fetch("silo-console")

    assert console.nounzip
    assert_equal "silo-console-darwin-amd64",
                 console.asset_name("v2.2.1", platform("darwin_amd64"))
  end

  def test_only_farrow_accepts_prereleases
    accepting = configs.values.select(&:allow_prerelease).map(&:name)

    assert_equal ["farrow"], accepting
  end

  def test_each_formula_has_one_marker_per_platform
    root = File.expand_path("..", __dir__)

    configs.each_value do |config|
      source = File.read(File.join(root, "Formula", "#{config.name}.rb"))
      PgstyTap::PLATFORMS.each do |platform|
        assert_equal 1, source.scan("# update: #{platform.key}").length,
                     "#{config.name} must have exactly one #{platform.key} marker"
      end
    end
  end
end
