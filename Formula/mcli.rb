# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
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
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-16T00-00-00Z/mcli_20260916000000.0.0_darwin_arm64.tar.gz"
      sha256 "1094ed5d7d14904cd3f2e0ce06211f59d968d11ad129520bb8ab2d4f674f6c83"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-16T00-00-00Z/mcli_20260916000000.0.0_darwin_amd64.tar.gz"
      sha256 "e0eea302b384a5ba0bcf3be1dc4a4e14213005d0fb8598482e2d88e9d61c9f20"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-16T00-00-00Z/mcli_20260916000000.0.0_linux_arm64.tar.gz"
      sha256 "b7008ca2a1bc5735b6585981c59a3640a0daa152dc789df3d1a0d0438787de82"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-09-16T00-00-00Z/mcli_20260916000000.0.0_linux_amd64.tar.gz"
      sha256 "4ba2814fd5507fbe6b4d237c359750b9119d28d7217495fa5b48002fcbd397ef"
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
