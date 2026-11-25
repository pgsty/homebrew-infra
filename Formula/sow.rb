# typed: strict
# frozen_string_literal: true

class Sow < Formula
  desc "Local RPM and DEB software repository manager"
  homepage "https://github.com/pgsty/sow"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.8.0/sow_0.8.0_darwin_arm64.tar.gz"
      sha256 "4f56903f52ebc7307d60a43b6b03f64628b866dd1a1f86ec29c6486804272c51"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.8.0/sow_0.8.0_darwin_amd64.tar.gz"
      sha256 "e4af9e9ff76cd7d0f56ee2970b4334c9ef864284871078f924a1800ad4785a6c"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.8.0/sow_0.8.0_linux_arm64.tar.gz"
      sha256 "483403ea407eb5d9251d9d693fb811f6bbe325d82bb0c8f5cacd2b890b53ba07"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.8.0/sow_0.8.0_linux_amd64.tar.gz"
      sha256 "d2de548971d399ff0a825cfebc0827bb78590be9af0948b18bc1d223248958b1"
    end
  end

  def install
    bin.install "sow"
    doc.install "README.md", "CHANGELOG.md", "THIRD_PARTY_NOTICES"
  end

  test do
    assert_match "sow #{version}", shell_output("#{bin}/sow version")
    assert_match "repository", shell_output("#{bin}/sow --help")
  end
end
