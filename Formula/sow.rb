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
      url "https://github.com/pgsty/sow/releases/download/v0.5.0/sow_0.5.0_darwin_arm64.tar.gz"
      sha256 "bb707c2506f408f9c4d14022e6e2e2a76ed130588f9527aa81ef79397d485efc"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.5.0/sow_0.5.0_darwin_amd64.tar.gz"
      sha256 "65ba1f4a160f7515022a3639356ab6fa3ec191acb2d99d491330fcc1f6014dff"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.5.0/sow_0.5.0_linux_arm64.tar.gz"
      sha256 "cbc5a34118c438df0657e80074507e8db7a048754182bc088d46afb5a6b7d5a2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.5.0/sow_0.5.0_linux_amd64.tar.gz"
      sha256 "3e14f2b1ce9debb0cbe3cc1a8983f0c46b843caa05eb92911714dcfdf6630d32"
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
