# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.93.0/redis_exporter-v1.93.0.darwin-arm64.tar.gz"
      sha256 "c942054d0c0e45435fdfed9991e9067e2d21139adee70dc924581914d376a4de"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.93.0/redis_exporter-v1.93.0.darwin-amd64.tar.gz"
      sha256 "81a340551a233e533cc6820d0ba97377a045dd46b7b44b7c751eef57c02080a5"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.93.0/redis_exporter-v1.93.0.linux-arm64.tar.gz"
      sha256 "c41f29c98ed45964f0588c8644f74b06bae703f696244536691f09ecf7b081a1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.93.0/redis_exporter-v1.93.0.linux-amd64.tar.gz"
      sha256 "ed2e531fa68ca2b8604544e19d1088fe409d0592b9ab4f3093fba0783c764972"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
