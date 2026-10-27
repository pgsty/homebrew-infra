# typed: strict
# frozen_string_literal: true

class Kes < Formula
  desc "Key encryption service for Silo and S3-compatible storage"
  homepage "https://github.com/pgsty/kes"
  version "2026-10-26T00-00-00Z"
  license "AGPL-3.0-only"

  livecheck do
    url :stable
    regex(/^(?:RELEASE[._-]?)?([\dTZ-]+)$/i)
    strategy :github_latest
  end

  on_macos do
    depends_on macos: :ventura

    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/kes/releases/download/RELEASE.2026-10-26T00-00-00Z/kes_20261026000000.0.0_darwin_arm64.tar.gz"
      sha256 "99aa7070e48ff8e4f1d126143e07e2bc0f234c3cefa00f1cc20ed2b51e2a0838"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/kes/releases/download/RELEASE.2026-10-26T00-00-00Z/kes_20261026000000.0.0_darwin_amd64.tar.gz"
      sha256 "20c989526980669f01d2197e941f27bc88772e27c9c392b8bd7e49adb7d4756d"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/kes/releases/download/RELEASE.2026-10-26T00-00-00Z/kes_20261026000000.0.0_linux_arm64.tar.gz"
      sha256 "5d93d9f6df2084174bb7369e5cdb1097038abdee00eeb05ce5e932312b44f909"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/kes/releases/download/RELEASE.2026-10-26T00-00-00Z/kes_20261026000000.0.0_linux_amd64.tar.gz"
      sha256 "9f73448e2f2b4515fc27f0c76adac37db2eee2f8e04d20babbc86380da2e8e99"
    end
  end

  def install
    bin.install "kes"
    doc.install "README.md", "README_ZH.md", "NOTICE", "CREDITS"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kes --version 2>&1")
    system bin/"kes", "identity", "new", "--key", "client.key", "--cert", "client.crt", "localhost"
    assert_match "PRIVATE KEY", (testpath/"client.key").read
    assert_match "CERTIFICATE", (testpath/"client.crt").read
  end
end
