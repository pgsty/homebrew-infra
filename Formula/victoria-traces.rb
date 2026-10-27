# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.1/victoria-traces-darwin-arm64-v0.12.1.tar.gz"
      sha256 "e706b527c55551af65faee1db8b45e0e094d36f79d5e2482bf427ca04b350b63"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.1/victoria-traces-darwin-amd64-v0.12.1.tar.gz"
      sha256 "c9c1d4e90eb9fd428b2695d2babee3e3a7b9a3c264793d2a5c1d4b36a8921d90"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.1/victoria-traces-linux-arm64-v0.12.1.tar.gz"
      sha256 "c08454c06f6db0a22f70c7d35ab0611e9dfee9db4143228ea56f4987399fece3"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.1/victoria-traces-linux-amd64-v0.12.1.tar.gz"
      sha256 "966c01559cc3f3452bae136106ec24c484f2383c4c4f9b51ebf2f6c4163721ba"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
