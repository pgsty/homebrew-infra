# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
  homepage "https://silo.pgsty.com"
  version "2026-08-26T17-15-27Z"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-08-26T17-15-27Z/mcli_20260826171527.0.0_darwin_arm64.tar.gz"
      sha256 "923ffa38308502b6ee0458cb9e7e94e67577cfba792dc3df5f86810d56224188"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-08-26T17-15-27Z/mcli_20260826171527.0.0_darwin_amd64.tar.gz"
      sha256 "286383281a4079d4caf849d4d77323620f3b93880b88ca4bca25434d17f03599"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-08-26T17-15-27Z/mcli_20260826171527.0.0_linux_arm64.tar.gz"
      sha256 "def74b8dde39a0b0771df9c080771fa39cb357e9f5617a1dc7b5f3556460b4ca"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-08-26T17-15-27Z/mcli_20260826171527.0.0_linux_amd64.tar.gz"
      sha256 "00ad237cc27ba6cbf12185f2d7a150bb6be31369b1eb72d6483c0d20515ff775"
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
