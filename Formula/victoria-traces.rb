# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.10.0/victoria-traces-darwin-arm64-v0.10.0.tar.gz"
      sha256 "cbe83f1d409cbb85fbf1c890c4a9b7fd34c1d74acec4dce2e0ebe46fcb260e38"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.10.0/victoria-traces-darwin-amd64-v0.10.0.tar.gz"
      sha256 "5b59f299cdc496eb754834aaff53b80b89fefa9d8a60a293f8999db3703b08b3"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.10.0/victoria-traces-linux-arm64-v0.10.0.tar.gz"
      sha256 "6f1cce34c0a091793bb4f0dd07270f83ca1a536c67dafb0b625914acbbf064a5"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.10.0/victoria-traces-linux-amd64-v0.10.0.tar.gz"
      sha256 "1bcd00766d319952874c237da03460107242c978cf2198767354d7b30dcb9f31"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
