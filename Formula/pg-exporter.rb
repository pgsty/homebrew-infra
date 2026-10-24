# typed: strict
# frozen_string_literal: true

class PgExporter < Formula
  desc "Advanced PostgreSQL and PgBouncer metrics exporter for Prometheus"
  homepage "https://pigsty.io/docs/pg_exporter"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.5.0/pg_exporter-1.5.0.darwin-arm64.tar.gz"
      sha256 "3fb47e285c2700227b0437c827fdbf0d87a93e24befb5e94f439082073700e8d"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.5.0/pg_exporter-1.5.0.darwin-amd64.tar.gz"
      sha256 "f3e5d03d3c3ca7df5e50e017e1c18ec78ccdc099f610296f674349acc1466975"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.5.0/pg_exporter-1.5.0.linux-arm64.tar.gz"
      sha256 "19f34db9e034d1437791af52676cf32e60a669d4a5036e0cc3efbe14efb61cde"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.5.0/pg_exporter-1.5.0.linux-amd64.tar.gz"
      sha256 "e372f6defb844b4bfbe3286b40dba3d4aae2ce72c4bed9980e3b9a56507aef56"
    end
  end

  def install
    bin.install "pg_exporter"
    etc.install "pg_exporter.yml"
  end

  def caveats
    <<~EOS
      Configure the PostgreSQL target before starting pg_exporter:
        export PG_EXPORTER_URL='postgres://user:pass@127.0.0.1:5432/postgres?sslmode=disable'
        pg_exporter --config #{etc}/pg_exporter.yml

      The installed collector configuration is:
        #{etc}/pg_exporter.yml
    EOS
  end

  test do
    assert_match "pg_exporter v#{version}", shell_output("#{bin}/pg_exporter --version 2>&1")
    assert_match "postgres target url", shell_output("#{bin}/pg_exporter --help 2>&1")
  end
end
