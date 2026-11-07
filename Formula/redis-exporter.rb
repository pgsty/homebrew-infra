# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.97.0/redis_exporter-v1.97.0.darwin-arm64.tar.gz"
      sha256 "b52d77217bad934ff99a95a28a21fc3e0b713dd55059c23ad127937a8ac95183"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.97.0/redis_exporter-v1.97.0.darwin-amd64.tar.gz"
      sha256 "968bb24d410c97726f6d0f639d41daa54650b577354275c9ba5d46e1b7731a9d"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.97.0/redis_exporter-v1.97.0.linux-arm64.tar.gz"
      sha256 "e49655203d1035aebef7acef7f08117288c33c3e43acf5c8f491c8eed20f199b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.97.0/redis_exporter-v1.97.0.linux-amd64.tar.gz"
      sha256 "492b849dfb359b619115b8f4d122eb59d1d8e666e366fbdeb9b5848732551557"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
