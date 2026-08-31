# typed: strict
# frozen_string_literal: true

class ZfsExporter < Formula
  desc "Prometheus exporter for ZFS metrics"
  homepage "https://github.com/waitingsong/zfs_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/waitingsong/zfs_exporter/releases/download/v3.8.1/zfs_exporter-3.8.1.darwin-arm64.tar.gz"
      sha256 "b4858913979db34438ca59a6b4ebd2b32a18dfd27897e77806f5c25700305b8f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/waitingsong/zfs_exporter/releases/download/v3.8.1/zfs_exporter-3.8.1.darwin-amd64.tar.gz"
      sha256 "ae2f5068717cba1bca7c70cbfd3769097f48536b05967c718cca40b439c193dd"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/waitingsong/zfs_exporter/releases/download/v3.8.1/zfs_exporter-3.8.1.linux-arm64.tar.gz"
      sha256 "865523de28f061082c3637aae9cb978c660a826138bb6a937e2631e3a493229e"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/waitingsong/zfs_exporter/releases/download/v3.8.1/zfs_exporter-3.8.1.linux-amd64.tar.gz"
      sha256 "cf0973ebca9e7c1292987f7a99e3ae7308ec6a770541654de1475c5b6f8c0496"
    end
  end

  def install
    bin.install "zfs_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zfs_exporter --version 2>&1")
  end
end
