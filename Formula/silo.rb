# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-11-12T00-00-00Z"
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
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0_darwin_arm64.tar.gz"
      sha256 "867a6cdf5521aaab34e87ed3f66df241e0d6e3dc11606721a15b7ed9e1da83c5"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0_darwin_amd64.tar.gz"
      sha256 "fce2cba6d04b1bdde301f6fc790270a714bd69ab43ada6510227db3bce757c37"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0_linux_arm64.tar.gz"
      sha256 "ae4b1aec3481751fb50980b8074773bcc64e2ce388eb150fa10336ad808a62f3"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-11-12T00-00-00Z/silo_20261112000000.0.0_linux_amd64.tar.gz"
      sha256 "378adce81515d31d48d8ac9b79effc62980e964c470fb06cc3ee8984786c2f4d"
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
