# typed: strict
# frozen_string_literal: true

class BlackboxExporter < Formula
  desc "Prometheus exporter for HTTP, DNS, TCP, ICMP, and gRPC probes"
  homepage "https://github.com/prometheus/blackbox_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.28.0/blackbox_exporter-0.28.0.darwin-arm64.tar.gz"
      sha256 "ec6c70ccca92e209dd22be76a4fa244f4bd31afdae3ddb2bb082144100ec52bb"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.28.0/blackbox_exporter-0.28.0.darwin-amd64.tar.gz"
      sha256 "12d7a3010235862d073bbb111b997870a50070bcda3b912bca8f0095cfda23c6"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.28.0/blackbox_exporter-0.28.0.linux-arm64.tar.gz"
      sha256 "63312be0983d85e5109710a7dc93df3051157ae581853fa3655d171cc1b2806e"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/blackbox_exporter/releases/download/v0.28.0/blackbox_exporter-0.28.0.linux-amd64.tar.gz"
      sha256 "caf5d242fb1cf6d5cb678f3f799f22703d4fafea26b03dcbbd7e1f1825e06329"
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
