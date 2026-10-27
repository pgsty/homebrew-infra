# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.96.0/redis_exporter-v1.96.0.darwin-arm64.tar.gz"
      sha256 "3d91d4e1a870f1716bbed6e767f181349993d49ed8eece30a57098f004ea6cca"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.96.0/redis_exporter-v1.96.0.darwin-amd64.tar.gz"
      sha256 "7b4d5a6b5c2787ab7231933bfce6b6090c1cb7e3f09e68466d737b679518c3fe"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.96.0/redis_exporter-v1.96.0.linux-arm64.tar.gz"
      sha256 "7adddb1d3f20afd096f8effa28b95b5f3fdc79347c0dc2c5d82ba253a4f9c782"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.96.0/redis_exporter-v1.96.0.linux-amd64.tar.gz"
      sha256 "7e828c0edd05e0984c3be380aacb389c230463db1c1f72141ec67267fc2b7510"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
