# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-10-26T00-00-00Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :ventura

    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-26T00-00-00Z/silo_20261026000000.0.0_darwin_arm64.tar.gz"
      sha256 "8478bdf9209962ea82a40f386785c5d0cadc09b0d04d5a58e160bfca7adfc59e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-26T00-00-00Z/silo_20261026000000.0.0_darwin_amd64.tar.gz"
      sha256 "6082d3df4e38f879a6ab00575da1becda8953095968f93f0243faa64c657dab1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-26T00-00-00Z/silo_20261026000000.0.0_linux_arm64.tar.gz"
      sha256 "2b70f568cc36fe7d4d83d10cbbf27d9bcfae0fba20ec96621225fce2e63054da"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-26T00-00-00Z/silo_20261026000000.0.0_linux_amd64.tar.gz"
      sha256 "4119e6da79be4f1b9ec9c619f72752f2e26e7447191dba969c02e4795fed8f92"
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
