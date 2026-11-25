# typed: strict
# frozen_string_literal: true

class Alertmanager < Formula
  desc "Handle alerts sent by Prometheus servers"
  homepage "https://prometheus.io/docs/alerting/latest/alertmanager/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.1/alertmanager-0.35.1.darwin-arm64.tar.gz"
      sha256 "c4d75dabccde271a4cb9d1df07386776070c0c60bc4e3e9888278067bba43455"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.1/alertmanager-0.35.1.darwin-amd64.tar.gz"
      sha256 "cf13ed90ced6bbde4d5d4ada0dfe43a71a6c12eff4065755492826468b0d396a"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.1/alertmanager-0.35.1.linux-arm64.tar.gz"
      sha256 "780c75de6941bcb31f2663679d190c9b62a714f5de5fb1e449213b4240e1279c"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.35.1/alertmanager-0.35.1.linux-amd64.tar.gz"
      sha256 "626bb9ae4486e14044705a6d6a0394f2ad8e3bf40df918f18f15b3d3775aa069"
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
