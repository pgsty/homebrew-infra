# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.92.0/redis_exporter-v1.92.0.darwin-arm64.tar.gz"
      sha256 "a79eafc02f920debd2806d16a22117c58026c77b5bc3b08e5e32f25e578801fa"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.92.0/redis_exporter-v1.92.0.darwin-amd64.tar.gz"
      sha256 "d4c1446f674a3680d8b690fbccaa4c968fe8a52fe6512bf8d9bcd4fd21d79fff"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.92.0/redis_exporter-v1.92.0.linux-arm64.tar.gz"
      sha256 "00ce9ba1fc0e6474e69d05e743e2b9b2ddeb89e35b23bf7c999a0667a737fd75"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.92.0/redis_exporter-v1.92.0.linux-amd64.tar.gz"
      sha256 "028736b15004c1f5c25508235a361d80f1989c577a458cc0dc97279c5269f709"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
