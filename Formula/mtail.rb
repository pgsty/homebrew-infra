# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.11/mtail_3.4.11_darwin_arm64.tar.gz"
      sha256 "80b60484fc60ca1b3cb0961c063e19a0f58db03c73b838969685b32b0f81f687"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.11/mtail_3.4.11_darwin_amd64.tar.gz"
      sha256 "86c100369a50b6ca15e1733f9f3a0e7e58466b2e8a21cf9dc3bc339292219f02"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.11/mtail_3.4.11_linux_arm64.tar.gz"
      sha256 "0fd30fc3430f36e984bfecdfda47e8b276ac8e85418596f324f36368e3e64b12"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.11/mtail_3.4.11_linux_amd64.tar.gz"
      sha256 "641a85ae818d8218ea4fc4bfde73b3dcea2b2bdbbc6cfb31c0d94091101c9c9e"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
