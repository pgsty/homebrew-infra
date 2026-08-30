# typed: strict
# frozen_string_literal: true

class Silo < Formula
  desc "S3-compatible object storage server maintained by PGSTY"
  homepage "https://silo.pgsty.com"
  version "2026-08-06T00-00-00Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-08-06T00-00-00Z/silo_20260806000000.0.0_darwin_arm64.tar.gz"
      sha256 "d6f463990b493de861ad5fbc1beee309f7d9384abafaf933a6a3e60a3b4e7c4e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-08-06T00-00-00Z/silo_20260806000000.0.0_darwin_amd64.tar.gz"
      sha256 "46ac3d5a66bba4b0c77b674c33cc55e2fe8087dacdd22c6dc952cab49947b9b4"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-08-06T00-00-00Z/silo_20260806000000.0.0_linux_arm64.tar.gz"
      sha256 "4389413672d8b2681130a2e518ae6609406671e0f0a5d34934c20701078ee1ad"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo/releases/download/RELEASE.2026-08-06T00-00-00Z/silo_20260806000000.0.0_linux_amd64.tar.gz"
      sha256 "d63d57cc7f0535e1aa116f9e5f42117dbfc4f63492da692b64d3ba6ded30e574"
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
