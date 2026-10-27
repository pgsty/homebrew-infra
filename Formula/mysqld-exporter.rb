# typed: strict
# frozen_string_literal: true

class MysqldExporter < Formula
  desc "Prometheus exporter for MySQL server metrics"
  homepage "https://github.com/prometheus/mysqld_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.21.0/mysqld_exporter-0.21.0.darwin-arm64.tar.gz"
      sha256 "fcf0a72f78e34e2169fefc4402eb2b651b4ff946e24ed42587925e34b7ebd44e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.21.0/mysqld_exporter-0.21.0.darwin-amd64.tar.gz"
      sha256 "fbba838286d0c55f961b5873c753dc2a58e116d52ce654360b3a98495054b151"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.21.0/mysqld_exporter-0.21.0.linux-arm64.tar.gz"
      sha256 "15e9dc9749a4cec2ddcb8195f1c4ff04ba4edc9ad6269efc4ee174aa1c7d5c07"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/mysqld_exporter/releases/download/v0.21.0/mysqld_exporter-0.21.0.linux-amd64.tar.gz"
      sha256 "dc38d4173ab07d1e2ec8699a3957d29d31c0b9619822cc3a451771c468f704c7"
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
