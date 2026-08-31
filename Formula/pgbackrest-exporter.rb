# typed: strict
# frozen_string_literal: true

class PgbackrestExporter < Formula
  desc "Prometheus exporter for pgBackRest"
  homepage "https://github.com/woblerr/pgbackrest_exporter"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.24.0/pgbackrest_exporter-0.24.0-macos-arm64.tar.gz"
      sha256 "a5af6bc7c02f48d9115b4a5cf2019415bdf7568f37363357432be89987b9c1f3"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.24.0/pgbackrest_exporter-0.24.0-macos-x86_64.tar.gz"
      sha256 "42c5575ac8e3bfaa524fd1ac7cf99e0a7e30c64a9b45e954fd461b4ef672e57f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.24.0/pgbackrest_exporter-0.24.0-linux-arm64.tar.gz"
      sha256 "2a606ea90be8bbdb8bda88f30d3f81a12db18de1dfcbc9f78e990609903bce95"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/woblerr/pgbackrest_exporter/releases/download/v0.24.0/pgbackrest_exporter-0.24.0-linux-x86_64.tar.gz"
      sha256 "a6e6a5adf85fb7c46dc3a3212efcba2045b9c543a1d162ddc868b821bd1d0f10"
    end
  end

  def install
    bin.install "pgbackrest_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pgbackrest_exporter --version 2>&1")
  end
end
