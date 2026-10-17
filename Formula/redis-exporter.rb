# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.94.0/redis_exporter-v1.94.0.darwin-arm64.tar.gz"
      sha256 "f7c78c61a0678b376bbae45812175e424a6df58b0742196c766ca87720229d13"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.94.0/redis_exporter-v1.94.0.darwin-amd64.tar.gz"
      sha256 "a3113246a4709c644e0b58e77ed19084fe650810d8fdc9ddf4574a63666dbad1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.94.0/redis_exporter-v1.94.0.linux-arm64.tar.gz"
      sha256 "a0b6bd03f1d3fbbb60d74690d7553cf8ef0614d2e1a457d81fa5f72d63d2de21"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.94.0/redis_exporter-v1.94.0.linux-amd64.tar.gz"
      sha256 "eaf433a64e6418235b25d4ec815d64759898f314d64dbb1fb074ca354f81b18b"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
