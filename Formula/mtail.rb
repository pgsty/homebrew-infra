# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.16/mtail_3.4.16_darwin_arm64.tar.gz"
      sha256 "40170e2554d13ecbfaa9510b62a5c347a5f801f4b67c82374b69c3a28f9c1865"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.16/mtail_3.4.16_darwin_amd64.tar.gz"
      sha256 "c29968b292c02dce6a68b5a35ccb406841beae671ec0a4394a68f7040551d8f2"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.16/mtail_3.4.16_linux_arm64.tar.gz"
      sha256 "abf00df8fde230ab3f448baa50e45f4b5169946bd3be8e695507cb155c2f48c1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.16/mtail_3.4.16_linux_amd64.tar.gz"
      sha256 "14017696e64e44bdefb856d29690fb00da96d01500a5c1f787e837b06587c629"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
