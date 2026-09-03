# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
  homepage "https://silo.pgsty.com"
  version "2026-09-03T07-13-05Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-03T07-13-05Z/mcli_20260903071305.0.0_darwin_arm64.tar.gz"
      sha256 "d1f889f23662aa488e70576014fdc390c7e02fb5ae2012f579ba66fbe1510d28"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-03T07-13-05Z/mcli_20260903071305.0.0_darwin_amd64.tar.gz"
      sha256 "89a24e043ea635010b3f3e0b59f9c7cce41388d307de33a2c5dd5d78046c649d"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-03T07-13-05Z/mcli_20260903071305.0.0_linux_arm64.tar.gz"
      sha256 "7962afc37c3e60e5758b19e819cb62d2f340ee655fad7b067e2ac9bc5716c2e8"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-03T07-13-05Z/mcli_20260903071305.0.0_linux_amd64.tar.gz"
      sha256 "cd7fcd449bb6b52e2eb727431ba6975b1e5d90df011a75869020ea9ac9e2b2a8"
    end
  end

  def install
    bin.install "mcli"
    doc.install "README.md", "README_ZH.md", "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcli --version 2>&1")
    system bin/"mcli", "mb", testpath/"bucket"
    assert_path_exists testpath/"bucket"
  end
end
