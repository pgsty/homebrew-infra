# typed: strict
# frozen_string_literal: true

class BlackboxExporter < Formula
  desc "Prometheus exporter for HTTP, DNS, TCP, ICMP, and gRPC probes"
  homepage "https://github.com/prometheus/blackbox_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.1/blackbox_exporter-0.29.1.darwin-arm64.tar.gz"
      sha256 "c47f7e5cd01fe105daab389a743b11b059bf5624ffeefa77b722586bbb0f30ab"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.1/blackbox_exporter-0.29.1.darwin-amd64.tar.gz"
      sha256 "bcee83ca8d5fdf6d9d80eac9cc6bc959304fdc30f60e1c7415ca25f84e7650b5"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.1/blackbox_exporter-0.29.1.linux-arm64.tar.gz"
      sha256 "c597b0d442c02c0f2c8f691cbc7784216c786fada28f300c7b914e1f94523834"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.29.1/blackbox_exporter-0.29.1.linux-amd64.tar.gz"
      sha256 "b82b81839e6317e84fdd367f46d7ddd3b773fa09cbe2e3d5633a59171d741e76"
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
