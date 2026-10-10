# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.0/victoria-traces-darwin-arm64-v0.12.0.tar.gz"
      sha256 "4bd3dbe20f73784567efd6ad07da2c6286d83365f7a800b805d1ce8040857858"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.0/victoria-traces-darwin-amd64-v0.12.0.tar.gz"
      sha256 "765825cc24ac21345ba92af8824996901a5032b29bdb768eb20975460792ac18"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.0/victoria-traces-linux-arm64-v0.12.0.tar.gz"
      sha256 "cb9756793fd0f19cc3ce1adecf6e0d1d4c8c88f1d084e96da02d266bdd96c814"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.12.0/victoria-traces-linux-amd64-v0.12.0.tar.gz"
      sha256 "67be031fb00635929b2d02a6e2ce7e5ebc8b2929f8e0d79fb54ab48bff0ca966"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
