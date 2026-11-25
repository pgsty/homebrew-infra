# typed: strict
# frozen_string_literal: true

class Mcli < Formula
  desc "Command-line client for Silo and S3-compatible object storage"
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
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_darwin_arm64.tar.gz"
      sha256 "b7e803f82445245cf2194cc7fd65ea949f2839207d8cbfde98cca340f206e4c9"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_darwin_amd64.tar.gz"
      sha256 "4b3486d80ea88a4085a4fc5327f98333820a8f757a87d805ff96bb089cdf7e28"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_linux_arm64.tar.gz"
      sha256 "4ea59d2f278c96b25e380289fd2ee9bc49faa342687074f031805cb7b34fbe1a"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/mc/releases/download/RELEASE.2026-11-12T00-00-00Z/mcli_20261112000000.0.0_linux_amd64.tar.gz"
      sha256 "68875c7fdd06a76af12b74753506df65226d1bec65a405d2617d76448c229ba2"
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
