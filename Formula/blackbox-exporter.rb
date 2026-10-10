# typed: strict
# frozen_string_literal: true

class BlackboxExporter < Formula
  desc "Prometheus exporter for HTTP, DNS, TCP, ICMP, and gRPC probes"
  homepage "https://github.com/prometheus/blackbox_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.0/blackbox_exporter-0.29.0.darwin-arm64.tar.gz"
      sha256 "5f4f1407f9f67a5c9a6df67803bb3a508df0a818fec885bf9790d141ac7e8c2e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.0/blackbox_exporter-0.29.0.darwin-amd64.tar.gz"
      sha256 "8c30ab992dbe8d2bdde45654df2c3dbbd0ceed6f951ddbbbfbb1c1138e09b1b7"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.0/blackbox_exporter-0.29.0.linux-arm64.tar.gz"
      sha256 "743c490a2386c5b77ad13e7af30cde48651c03ffe9f61d39b99c578baa7e8e34"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.0/blackbox_exporter-0.29.0.linux-amd64.tar.gz"
      sha256 "5512929259bb6164f68ebe20ce433ec43b8609e3a79c95324f5020e931488fb4"
    end
  end

  def install
    bin.install "blackbox_exporter"
    etc.install "blackbox.yml"
    doc.install "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/blackbox_exporter --version 2>&1")
  end
end
