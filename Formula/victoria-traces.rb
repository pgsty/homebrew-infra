# typed: strict
# frozen_string_literal: true

class VictoriaTraces < Formula
  desc "Tracing backend with native OpenTelemetry support"
  homepage "https://docs.victoriametrics.com/victoriatraces/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.13.0/victoria-traces-darwin-arm64-v0.13.0.tar.gz"
      sha256 "b0553e27fa77d979ab14032a3463dab5464776883cfb0bdc61fd071db93b8650"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.13.0/victoria-traces-darwin-amd64-v0.13.0.tar.gz"
      sha256 "2847b3a8bafdd6755784fa1d3d5b5e08372587da08bce7098d882670f30b265e"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.13.0/victoria-traces-linux-arm64-v0.13.0.tar.gz"
      sha256 "210bc863666865ba9a4ff0a19901318042da0c474d248fec69ca71c07b1e5f7a"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/VictoriaMetrics/VictoriaTraces/releases/download/v0.13.0/victoria-traces-linux-amd64-v0.13.0.tar.gz"
      sha256 "789e006d076f3c8b99de7bb1d0277024a7db776db0294d1c27fcc5422d98c4bc"
    end
  end

  def install
    bin.install "victoria-traces-prod" => "victoria-traces"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/victoria-traces --version 2>&1")
  end
end
