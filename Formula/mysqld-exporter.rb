# typed: strict
# frozen_string_literal: true

class MysqldExporter < Formula
  desc "Prometheus exporter for MySQL server metrics"
  homepage "https://github.com/prometheus/mysqld_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.20.0/mysqld_exporter-0.20.0.darwin-arm64.tar.gz"
      sha256 "c0f834a7d015138fdb0fad3fa6a1076fcf0361ae8b90c58f2257cab76f33382b"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.20.0/mysqld_exporter-0.20.0.darwin-amd64.tar.gz"
      sha256 "ed5bb6a130156586c995840dacc4faad1cdfc1624741ea28a873e56ba17232ae"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.20.0/mysqld_exporter-0.20.0.linux-arm64.tar.gz"
      sha256 "837804c0a59cbe1f3ab46670dec1b4c37940c8d48062374691b27f1f37abf8dd"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.20.0/mysqld_exporter-0.20.0.linux-amd64.tar.gz"
      sha256 "5773496e9962ca3817b3599fe4d74f218c95c1295eb2a742462df8e035fe51bd"
    end
  end

  def install
    bin.install "mysqld_exporter"
    doc.install "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mysqld_exporter --version 2>&1")
  end
end
