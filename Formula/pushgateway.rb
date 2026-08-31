# typed: strict
# frozen_string_literal: true

class Pushgateway < Formula
  desc "Prometheus gateway for metrics from short-lived jobs"
  homepage "https://prometheus.io/docs/practices/pushing/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.3/pushgateway-1.11.3.darwin-arm64.tar.gz"
      sha256 "7a6f3e643a1b744b57fd3233df062d56c771bb1c623bae9e322c5127dddf8c04"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.3/pushgateway-1.11.3.darwin-amd64.tar.gz"
      sha256 "3626e11ba4d828bcfc305b7e06d0d5f507f3837190d552f837480be0073219de"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.3/pushgateway-1.11.3.linux-arm64.tar.gz"
      sha256 "727ff0098943657b44c21a029be9d9fcc4f249ec72dcb9f0a34aa66b2d5f1ecc"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/pushgateway/releases/download/v1.11.3/pushgateway-1.11.3.linux-amd64.tar.gz"
      sha256 "bb0a44dee0953df9e8cd3c082981ff50327de56d965d83bdd9b0957d83921e38"
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
