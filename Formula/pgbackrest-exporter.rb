# typed: strict
# frozen_string_literal: true

class PgbackrestExporter < Formula
  desc "Prometheus exporter for pgBackRest"
  homepage "https://github.com/woblerr/pgbackrest_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.25.0/pgbackrest_exporter-0.25.0-macos-arm64.tar.gz"
      sha256 "9646219db516eadfe6ee289c0d0408ff97f3a266e8eaedd6568f565c2e936f59"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.25.0/pgbackrest_exporter-0.25.0-macos-x86_64.tar.gz"
      sha256 "f8737fb330be199517e0e937dacdff6c6eefc3a355250b72066c07491b4c7ace"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.25.0/pgbackrest_exporter-0.25.0-linux-arm64.tar.gz"
      sha256 "4d18143573f181981b7cc886b5bd5c91c4079167acba7660c5e1fb585db10876"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.25.0/pgbackrest_exporter-0.25.0-linux-x86_64.tar.gz"
      sha256 "d0372c14757fb8590e7275401c6aeb36909bebf6135c1d72039547a8d3321054"
    end
  end

  def install
    bin.install "pgbackrest_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pgbackrest_exporter --version 2>&1")
  end
end
