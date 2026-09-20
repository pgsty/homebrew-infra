# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.1/victoria-traces-darwin-arm64-v0.11.1.tar.gz"
      sha256 "06dfee9581fadb5c05cbc214f46a1599d6d1453eb9658df4554d2c44588250e2"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.1/victoria-traces-darwin-amd64-v0.11.1.tar.gz"
      sha256 "62c9a80b0443aa2d888b60bc9879b30e0a1e7d1547134ca3ba4ec27b54983489"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.1/victoria-traces-linux-arm64-v0.11.1.tar.gz"
      sha256 "c258b0b26276b80654635d667ca0aff0d61f546ea591b9de95f0127636e351ad"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.11.1/victoria-traces-linux-amd64-v0.11.1.tar.gz"
      sha256 "ac831f2ed12806caa29b8369bb9e0a0fcd8153029f631e4784f51f83420c7f30"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
