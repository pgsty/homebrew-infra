# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-09-16T00-00-00Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-16T00-00-00Z/silo_20260916000000.0.0_darwin_arm64.tar.gz"
      sha256 "6bb442de06b644eeaf7ab0e5827e6fd5ec1dfcc9e9d482343d94f81c4047edb8"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-16T00-00-00Z/silo_20260916000000.0.0_darwin_amd64.tar.gz"
      sha256 "3e7aca5038c79f6c3f6047f16fdb7b84eb2a15f9b728474b7ac579b0ae7b13f3"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-16T00-00-00Z/silo_20260916000000.0.0_linux_arm64.tar.gz"
      sha256 "6e697d3e1d70f2343fe829cd6820a0b840d4619f1dde546424de80e529636ed2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-09-16T00-00-00Z/silo_20260916000000.0.0_linux_amd64.tar.gz"
      sha256 "381e745510a8fb64323d7bb3207f95984b7f4ed826f4fcad318f97683c420c73"
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
