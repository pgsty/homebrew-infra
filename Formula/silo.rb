# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-09-03T13-18-01Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-03T13-18-01Z/silo_20260903131801.0.0_darwin_arm64.tar.gz"
      sha256 "bcfd90d51ab6dffc34193aac260464097bb1d2decdd2598538e618bc02ada668"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-03T13-18-01Z/silo_20260903131801.0.0_darwin_amd64.tar.gz"
      sha256 "35b4121f6ca2ba79514c3536e5f7f79ae8f7fe6fb88288efbdfa2ae8d5283131"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-03T13-18-01Z/silo_20260903131801.0.0_linux_arm64.tar.gz"
      sha256 "311846ca9387de36f8e34daa8bf1a130684cc7b8c61aa39581264249eb8df0cf"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-03T13-18-01Z/silo_20260903131801.0.0_linux_amd64.tar.gz"
      sha256 "cbe5c01eac0a97ccb22fa252eafa432e8608bfde7e3ea27a324cb5ed625a1e96"
    end
  end

  def install
    bin.install "silo"
    doc.install "README.md", "NOTICE"
  end

  post_install_steps do
    mkdir_p "silo", base: :var
    mkdir_p "silo/certs", base: :etc
  end

  service do
    run [opt_bin/"silo", "server", "--certs-dir=#{etc}/silo/certs", "--address=:9000", var/"silo"]
    keep_alive true
    working_dir HOMEBREW_PREFIX
    log_path var/"log/silo.log"
    error_log_path var/"log/silo.log"
  end

  def caveats
    <<~EOS
      Silo stores data in:
        #{var}/silo

      Configure production credentials before starting the service. Silo keeps
      MinIO-compatible MINIO_ROOT_USER and MINIO_ROOT_PASSWORD environment names.

      Start an interactive server with:
        silo server #{var}/silo

      Or manage the default service with:
        brew services start silo
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/silo --version 2>&1")
    assert_match "server", shell_output("#{bin}/silo server --help 2>&1")
  end
end
