# typed: strict
# frozen_string_literal: true

class Alertmanager < Formula
  desc "Handle alerts sent by Prometheus servers"
  homepage "https://prometheus.io/docs/alerting/latest/alertmanager/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.0/alertmanager-0.34.0.darwin-arm64.tar.gz"
      sha256 "0cb31efe439c58ab77594b62a28f9de95f2d08beccf0f11eba4b822b2f549b82"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.0/alertmanager-0.34.0.darwin-amd64.tar.gz"
      sha256 "2c76c6bb30f030296cbfbf803bfd99494987197fcb8743f73ef5f351d568ce97"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.0/alertmanager-0.34.0.linux-arm64.tar.gz"
      sha256 "a96ef16598ddc58e84d28167b3352b30e3205698d76c56ef467e4504d7664da4"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.0/alertmanager-0.34.0.linux-amd64.tar.gz"
      sha256 "19c75a11d8c03dc4ade7abdbddfb3a8f28c9e7b000d0849cda0cd71dffd74a03"
    end
  end

  def install
    bin.install "alertmanager", "amtool"
    etc.install "alertmanager.yml"
    doc.install "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/alertmanager --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/amtool --version 2>&1")
  end
end
