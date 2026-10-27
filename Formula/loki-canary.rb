# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.9/loki-canary-darwin-arm64.zip"
      sha256 "efcebe002530f689ec2fd920bf4c3b2955039bace4ee85c2b1166a6ebedc87f6"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.9/loki-canary-darwin-amd64.zip"
      sha256 "5779360b6b5ddc98f949e9dae3917c1e3683c2d7fb354323521ac4cda30820e7"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.9/loki-canary-linux-arm64.zip"
      sha256 "50bac237178fb9cacc01127c06c63272cd0fcb1eeb19b686502ee1db0b90898d"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.9/loki-canary-linux-amd64.zip"
      sha256 "1b964da07d933aabfc2c0440a8050398478ca29405dca9f347484e961493da3b"
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
