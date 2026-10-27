# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.18/mtail_3.4.18_darwin_arm64.tar.gz"
      sha256 "94e13602b06f508e26632bed9518c5a9b5b630b62ef282206557b805777e4cb9"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.18/mtail_3.4.18_darwin_amd64.tar.gz"
      sha256 "76816ca15adc0981c8a08a49b9bcbe3e0d54fd8256ea524b2c3df987aaba8522"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.18/mtail_3.4.18_linux_arm64.tar.gz"
      sha256 "1ff08a2e45b984ff3b42aa8248778da758bbe434985b8a04e713eb4a3f282137"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.18/mtail_3.4.18_linux_amd64.tar.gz"
      sha256 "d963e3edad8dc425092f2fbb1e617c1fd70552c8dbba7529d9a16b2244753311"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
