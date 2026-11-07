# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.6.20/loki-canary-darwin-arm64.zip"
      sha256 "68b6c150150b9a78fa9443b0061c480501533098bedadc1997d459af15737326"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.6.20/loki-canary-darwin-amd64.zip"
      sha256 "7c40cca0b1ce64e42b718dbce180b7259d4b565d984bf59b5139b27b01c4ef47"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.6.20/loki-canary-linux-arm64.zip"
      sha256 "74cbf901bca81d1d6c75e725b6790973c054097368541a460843db8d2ea375ea"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.6.20/loki-canary-linux-amd64.zip"
      sha256 "24663354f599d2c0e66179d01701840abfe38df2ad8ddb00118f072b423859b4"
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
