# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v4.0.0-rc.4/loki-canary-darwin-arm64.zip"
      sha256 "cd7e5a5ac661bd8b7fe63f6e40c5bdf3ec447a836f714afa16979a3caae1e868"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v4.0.0-rc.4/loki-canary-darwin-amd64.zip"
      sha256 "973dc3ba73eccf04aeabd3d820c822f7ee88895dcb88c1eb42ce9352b646da30"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v4.0.0-rc.4/loki-canary-linux-arm64.zip"
      sha256 "905f763bf8705fe5f937c78dafa597761481529d32b3352b72c221dd06032ba6"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v4.0.0-rc.4/loki-canary-linux-amd64.zip"
      sha256 "d19d4058fadea7534f06f602d7a377f7e4c809b53270ab49f22f35d62f0d247c"
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
