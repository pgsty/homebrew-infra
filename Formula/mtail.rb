# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.19/mtail_3.4.19_darwin_arm64.tar.gz"
      sha256 "fe6682acad47444d1b7a3d809444f58e5aedca2a6e69aa6dff0a2b731650710c"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.19/mtail_3.4.19_darwin_amd64.tar.gz"
      sha256 "2e4411c2357c1c5dd6fabb07e20b2d83a6604bf11b4a9bdfe09875d36dd00622"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.19/mtail_3.4.19_linux_arm64.tar.gz"
      sha256 "024acc2ca6948783476786b1e7b244d09febf9b31b8ff613704bb9e4e091bf64"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.19/mtail_3.4.19_linux_amd64.tar.gz"
      sha256 "4527fd9567f43d729ceab96442a2836f78fb3555c4427090086b20297c46d8c3"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
