# typed: strict
# frozen_string_literal: true

class Pushgateway < Formula
  desc "Prometheus gateway for metrics from short-lived jobs"
  homepage "https://prometheus.io/docs/practices/pushing/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.4/pushgateway-1.11.4.darwin-arm64.tar.gz"
      sha256 "ea2f59f76ba498268efb0b8d6fb0aa0bf428ee74e24301531b30e9eed5222041"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.4/pushgateway-1.11.4.darwin-amd64.tar.gz"
      sha256 "fb8367fdf97df4a53df6e1508e07e4f8f747184f1c1b6325d2884b8c64d6e979"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.4/pushgateway-1.11.4.linux-arm64.tar.gz"
      sha256 "022adcb52b919a800a5deeefb19533d6f3a76decd86af424197ccd5f1448e81d"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.4/pushgateway-1.11.4.linux-amd64.tar.gz"
      sha256 "e6d631d1f511ce386de2dcbc3bd18a7165d8117588f2aefea15e89cf794751b3"
    end
  end

  def install
    bin.install "pushgateway"
    doc.install "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pushgateway --version 2>&1")
  end
end
