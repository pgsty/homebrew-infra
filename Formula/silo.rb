# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-10-18T00-00-00Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-18T00-00-00Z/silo_20261018000000.0.0_darwin_arm64.tar.gz"
      sha256 "fdbc57117200c47d87d769301a32be54589844066028ec57efcc48c2886296f9"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-18T00-00-00Z/silo_20261018000000.0.0_darwin_amd64.tar.gz"
      sha256 "17bac18cc32b5057c9d116033734c34545d431d75b4efb8dc10c7a0fac7e619f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-18T00-00-00Z/silo_20261018000000.0.0_linux_arm64.tar.gz"
      sha256 "f711c4d46d57c3b3fa365afab01150aab59b77c617f3d7987d77c6f9b6ea38b6"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-10-18T00-00-00Z/silo_20261018000000.0.0_linux_amd64.tar.gz"
      sha256 "e069b6425f0de944fea6c301773d5620fe8992bf0d16b6c5e42be57d666ee794"
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
