# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.8/loki-canary-darwin-arm64.zip"
      sha256 "7c9ba87ea2a66d6cbe31e8561137f0bd4485e7355c1cb2ed15a0905cab44891a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.8/loki-canary-darwin-amd64.zip"
      sha256 "f8c52c1db60e6f69b0ea6d1878ee6b9247b59689876bcc42cadf7680aa8cd3b9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.8/loki-canary-linux-arm64.zip"
      sha256 "f21dbf9629d85963bed76e1974c1ffabc87f6cf21c58c6895699f4945be32acf"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.8/loki-canary-linux-amd64.zip"
      sha256 "c396f0a517366f3cef5e193b7820996129f51083a9eff244949ad1f5e6ac2cbd"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "loki-canary-#{platform}-#{arch}" => "loki-canary"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/loki-canary --version 2>&1")
  end
end
