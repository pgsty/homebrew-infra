# typed: strict
# frozen_string_literal: true

class Sow < Formula
  desc "Local RPM and DEB software repository manager"
  homepage "https://github.com/pgsty/sow"
  version "0.4.0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.4.0/sow_0.4.0_darwin_arm64.tar.gz"
      sha256 "e5a4a883b386a947b16931c7b56eaca41fb9bad3a232d7a900547846b3f94b79"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.4.0/sow_0.4.0_darwin_amd64.tar.gz"
      sha256 "760672c04327fa6dea8c0042baf09dba1444132aecc9f2af7c2d3ece6df20c04"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.4.0/sow_0.4.0_linux_arm64.tar.gz"
      sha256 "2aa3bd177b15581529f707150ef68b131e8eee834dcde0d5f74b11bd612f5b9b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.4.0/sow_0.4.0_linux_amd64.tar.gz"
      sha256 "ca1f18fa082c9566d0e884858879b6af983ffd9147c1aef9b45ad3603b63cd61"
    end
  end

  def install
    bin.install "sow"
    doc.install "README.md", "CHANGELOG.md"
  end

  test do
    assert_match "sow #{version}", shell_output("#{bin}/sow version")
    assert_match "repository", shell_output("#{bin}/sow --help")
  end
end
