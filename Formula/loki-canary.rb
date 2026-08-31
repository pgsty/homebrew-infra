# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.7/loki-canary-darwin-arm64.zip"
      sha256 "260f5fbd3e50238616cecc5b615f4aa09bc1054df0609e90c650b0378ff30086"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.7/loki-canary-darwin-amd64.zip"
      sha256 "70bfc78f163779385a0a174a8cf329e398adf6e5e28496d835f9a9a69a50436b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.7.7/loki-canary-linux-arm64.zip"
      sha256 "d3d73fa4c6c88a667342d2dc0ed9218874235a8ef87b410a789a8f5add37e734"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.7.7/loki-canary-linux-amd64.zip"
      sha256 "1ba114e3838fbcc36daa7dbb35c6cb07e33030e1d0a68573527ca86300871f2d"
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
