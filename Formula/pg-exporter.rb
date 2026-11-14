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
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.6.1/pg_exporter-1.6.1.darwin-arm64.tar.gz"
      sha256 "9ace0b48115497f2b3d7d9e1660e13e6a778472c66c8ec5ff679faa2fa61c662"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.6.1/pg_exporter-1.6.1.darwin-amd64.tar.gz"
      sha256 "496c42f329fc265e952c964afaef29ebc7d2d4640180872a735a84eebb962774"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.6.1/pg_exporter-1.6.1.linux-arm64.tar.gz"
      sha256 "91da5400ae31d42925af721c7d5f8eb0befcbb104d8a14ae5f08707abb5e333b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.6.1/pg_exporter-1.6.1.linux-amd64.tar.gz"
      sha256 "e8fdf64c352081720a53420a2c7ea095654078d5fab5f6213786bb6476791fdf"
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
