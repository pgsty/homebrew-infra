# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.10/loki-canary-darwin-arm64.zip"
      sha256 "fff29540edf914365798c950c6f05fca282642d59b79b499f0309dcf91e78de1"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.10/loki-canary-darwin-amd64.zip"
      sha256 "7595e22d76babff55893245cd5104165285a64fc8a3745be35fbfe8a6b99773b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.10/loki-canary-linux-arm64.zip"
      sha256 "e2c7c426b3857d284a70bd0545d0ce441ad7054f7a9d45130e4cef4732993bb9"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.10/loki-canary-linux-amd64.zip"
      sha256 "16a1e750005bad5c98c93c1c26088eeb767da7b6c13b3c5aa44db80e80721345"
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
