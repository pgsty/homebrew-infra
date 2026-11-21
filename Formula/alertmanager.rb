# typed: strict
# frozen_string_literal: true

class Alertmanager < Formula
  desc "Handle alerts sent by Prometheus servers"
  homepage "https://prometheus.io/docs/alerting/latest/alertmanager/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.0/alertmanager-0.35.0.darwin-arm64.tar.gz"
      sha256 "06c0700ebdee77688eddc12e1c71c52e88efbb348f832ecb7a9ff699f9106fba"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.0/alertmanager-0.35.0.darwin-amd64.tar.gz"
      sha256 "7b39d9f48640186e7af4cb92bcc071fecfad54f90b43d8cd7dac92f20f511df9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.0/alertmanager-0.35.0.linux-arm64.tar.gz"
      sha256 "b7a8a69f849c6f837348b05476195862152f9de8eae338eb36ab29801d341654"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.0/alertmanager-0.35.0.linux-amd64.tar.gz"
      sha256 "6c7752a903c40c8a749e0b29df9240437e4fbb8228068d0af8807377db32addd"
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
