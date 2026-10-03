# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.14/mtail_3.4.14_darwin_arm64.tar.gz"
      sha256 "599a03a91e8b6400c0d05df837041291acbd7d2c57c5ada1bb6b9016531ca960"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.14/mtail_3.4.14_darwin_amd64.tar.gz"
      sha256 "a521dcd8fb438f8207823d68ae12da45a370095de8148e6a8787a4b50fe57c37"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.14/mtail_3.4.14_linux_arm64.tar.gz"
      sha256 "05c484b6a03510f8e6dfffccfe43453e71d357168c157342448e174f3263ca22"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.14/mtail_3.4.14_linux_amd64.tar.gz"
      sha256 "a01c7713d97c8725067e3f6cf2a5dccccb7aee62c8af57ffcff3a658f48b1b29"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
