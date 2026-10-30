# typed: strict
# frozen_string_literal: true

class Alertmanager < Formula
  desc "Handle alerts sent by Prometheus servers"
  homepage "https://prometheus.io/docs/alerting/latest/alertmanager/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.2/alertmanager-0.34.2.darwin-arm64.tar.gz"
      sha256 "dc1fcd4ad3e8bef111683eaf385aa5b2b02493277bca9126c129e0a39fc68a4f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.2/alertmanager-0.34.2.darwin-amd64.tar.gz"
      sha256 "fa5a50303c58771c261fcbed4cf5f9a852cf2c6064942adbd92c6859c65c5f93"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.2/alertmanager-0.34.2.linux-arm64.tar.gz"
      sha256 "5aaad82e3d167c30c06ce7d38677d2892a6f66f4c3613ea17af7481750fdd0b0"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.2/alertmanager-0.34.2.linux-amd64.tar.gz"
      sha256 "17ee14acd0f6ba6e25a436ff223d9c17ddd5cf484f543ad12f0932eaa89ba186"
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
