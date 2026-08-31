# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.90.0/redis_exporter-v1.90.0.darwin-arm64.tar.gz"
      sha256 "3090bfae1f09c00b7a6de594e4b8268a2744f4d20ec6d460b2ae1b2e57916415"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.90.0/redis_exporter-v1.90.0.darwin-amd64.tar.gz"
      sha256 "fd962a68deb47cc03e172256b78cde3132063c8376d291d8f0fc663686ea87bc"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.90.0/redis_exporter-v1.90.0.linux-arm64.tar.gz"
      sha256 "ddea9ed55be95e7588d7dcc03394d7b1e13c956c94f65da576b25d95c3d59c73"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.90.0/redis_exporter-v1.90.0.linux-amd64.tar.gz"
      sha256 "311205fdc6ea2fccd6368de32e0cbd1497d10bffd61e51cad7334a3898e9d508"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
