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
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.4.1/pg_exporter-1.4.1.darwin-arm64.tar.gz"
      sha256 "6fe0b19398983587fbe5e9a31dd8de0aeaf03b6b91a6fe22fc71f63ba703a79f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.4.1/pg_exporter-1.4.1.darwin-amd64.tar.gz"
      sha256 "e6de4c890af8d1c54b4a597e9fd02329e9caa543604c8406270a7a3c842d76f4"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.4.1/pg_exporter-1.4.1.linux-arm64.tar.gz"
      sha256 "e111974a12175d5f65c4ee0fb888604e6b343d893476ef4e88264a4c9601e8b4"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pg_exporter/releases/download/v1.4.1/pg_exporter-1.4.1.linux-amd64.tar.gz"
      sha256 "f2f952dbcf1ae09027bcee4ea4921d2b34f9f58ffbc7e3a2d42113f2cc94a340"
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
