# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.0/victoria-traces-darwin-arm64-v0.11.0.tar.gz"
      sha256 "18b57270e2aa7e64790f82513154621558b33b2f65721d5281d14b3151bd0735"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.0/victoria-traces-darwin-amd64-v0.11.0.tar.gz"
      sha256 "4a0de9d82681f33e4aef413464800169e474c2bd80df78480d6fc720fe679b37"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.0/victoria-traces-linux-arm64-v0.11.0.tar.gz"
      sha256 "18176f73fac3b9c7ea88ceba637c7f997593635e446e45e789dc68f1de6d0359"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.0/victoria-traces-linux-amd64-v0.11.0.tar.gz"
      sha256 "3089ead89b9a95369e265a5321b1ad8e670c3c94afbc9a9faaa9a356346b5b95"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
