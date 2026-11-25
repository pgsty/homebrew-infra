# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.99.0/redis_exporter-v1.99.0.darwin-arm64.tar.gz"
      sha256 "1b1e773d7c52cf5530d95ec2da1c73c25fab8b5e9c74b125ac598b4078d7d560"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.99.0/redis_exporter-v1.99.0.darwin-amd64.tar.gz"
      sha256 "b22ea16e2a1b5f2a0f756c9d961d99b6ffdc768e6945967aa0a686547930f1a9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.99.0/redis_exporter-v1.99.0.linux-arm64.tar.gz"
      sha256 "3b6959d384781caa83e2d434d867d4b9251ae0bdccb13098aadb7b3ce26669fe"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.99.0/redis_exporter-v1.99.0.linux-amd64.tar.gz"
      sha256 "93c7949cb06ea7075cb3b67a8c60937848063d0c9f2ab0521857e44720735ac7"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
