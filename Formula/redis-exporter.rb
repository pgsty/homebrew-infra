# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.91.1/redis_exporter-v1.91.1.darwin-arm64.tar.gz"
      sha256 "6e37b64f70919704bef2a3d55cf4afa608f0b383f749e891c2fe5c26dbe6e5d4"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.91.1/redis_exporter-v1.91.1.darwin-amd64.tar.gz"
      sha256 "2f1d510814f244a5bac83ba6529ba8fffa38f594eaaba4f61821ed781b7259ab"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.91.1/redis_exporter-v1.91.1.linux-arm64.tar.gz"
      sha256 "7ee124bd17733cce535b87da17e79f0346d3edb4a20759cf3bfca8b4e0d6886f"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.91.1/redis_exporter-v1.91.1.linux-amd64.tar.gz"
      sha256 "4552451000b6345011bfc50d77fd3be625aa0be47ac07e98a40384038ecffaab"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
