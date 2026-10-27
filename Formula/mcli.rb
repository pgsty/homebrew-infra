# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
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
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-26T00-00-00Z/mcli_20261026000000.0.0_darwin_arm64.tar.gz"
      sha256 "6766e964afdbfc481c39999c08fdd5d539d22876c8d8ba8701b0369a912d3e7a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-26T00-00-00Z/mcli_20261026000000.0.0_darwin_amd64.tar.gz"
      sha256 "3643d18c45db97383a2fb6b457af2029040ca27d0110809eeb98f7dbcf3429e7"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-26T00-00-00Z/mcli_20261026000000.0.0_linux_arm64.tar.gz"
      sha256 "47b1a558f766f26bef5beeedd5300e082bcdec07a5e7d4a16f5f9d168f5275d1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-26T00-00-00Z/mcli_20261026000000.0.0_linux_amd64.tar.gz"
      sha256 "e86295bb11ed59369c0560f030d59abd42fb64a376b1d7e9799ec2e8596ebf64"
    end
  end

  def install
    bin.install "mcli"
    doc.install "README.md", "README_ZH.md", "NOTICE", "CREDITS"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcli --version 2>&1")
    system bin/"mcli", "mb", testpath/"bucket"
    assert_path_exists testpath/"bucket"
  end
end
