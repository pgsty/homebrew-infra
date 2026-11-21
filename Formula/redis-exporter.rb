# typed: strict
# frozen_string_literal: true

class RedisExporter < Formula
  desc "Prometheus exporter for Redis metrics"
  homepage "https://github.com/oliver006/redis_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.98.0/redis_exporter-v1.98.0.darwin-arm64.tar.gz"
      sha256 "6e5c7d0aec4dbf95558b605ba6571725fdb0912941606c18ba03facab21614df"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.98.0/redis_exporter-v1.98.0.darwin-amd64.tar.gz"
      sha256 "fdffc81b9bdc2835821a78d54f099bd7b0ef75294a4246187117d1c86ddca69b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.98.0/redis_exporter-v1.98.0.linux-arm64.tar.gz"
      sha256 "e5a8b9a31d6c9ea672b88889a31f3e453b8e4ed6cb511646af352d905b610295"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/oliver006/redis_exporter/releases/download/v1.98.0/redis_exporter-v1.98.0.linux-amd64.tar.gz"
      sha256 "b7bc4d0199bc824f63015353562cf02f5849bff26657289bfd5727827a869119"
    end
  end

  def install
    bin.install "redis_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/redis_exporter --version 2>&1")
  end
end
