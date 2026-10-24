# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
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
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-18T00-00-00Z/mcli_20261018000000.0.0_darwin_arm64.tar.gz"
      sha256 "8f59032d60df667cbeb54ad0ddc336bde309031cc07696d7609f18780f2f9c38"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-18T00-00-00Z/mcli_20261018000000.0.0_darwin_amd64.tar.gz"
      sha256 "16e5d764f71629b2e3c4aed14668406d61c1c7415db3a419ee1d9e2e2a339789"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-18T00-00-00Z/mcli_20261018000000.0.0_linux_arm64.tar.gz"
      sha256 "17f3eb694ed34e155b331b1215832140749656d8d4b60e2e3a4d0573b8f320d7"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-10-18T00-00-00Z/mcli_20261018000000.0.0_linux_amd64.tar.gz"
      sha256 "b5392a642dbc9685b517ee901f032d1d5e88f41704436f0f08dde6060b577db3"
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
