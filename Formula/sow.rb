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
      url "https://github.com/pgsty/sow/releases/download/v0.6.1/sow_0.6.1_darwin_arm64.tar.gz"
      sha256 "4a0e35d91d93d571883762a24f040f088c39c855b73e5db80fc92e1c03226415"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.6.1/sow_0.6.1_darwin_amd64.tar.gz"
      sha256 "f0f092220d629285d64d0cb6defca0a9397e627855b252886a969f9fc1e78502"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.6.1/sow_0.6.1_linux_arm64.tar.gz"
      sha256 "7553097c20d3e6b9c8943666e14506fd4f68ecef5d9985143a24066abb454815"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.6.1/sow_0.6.1_linux_amd64.tar.gz"
      sha256 "8b173bf91d37501f4174b17f051d63bf6e078ccced6bce188d58f6ae5f385a6b"
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
