# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.13/mtail_3.4.13_darwin_arm64.tar.gz"
      sha256 "f7e04333b0da4a332f3b2392df916d5ef38bbc72b182bb55eb7692a7b013ca69"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.13/mtail_3.4.13_darwin_amd64.tar.gz"
      sha256 "51bee385c263195e5b67e1597c46aefb822e8d60dc73d86570aa93950bf53ca0"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.13/mtail_3.4.13_linux_arm64.tar.gz"
      sha256 "d52b2c00691aaed07e71c0f7d11a602f5bbaa2816d41f4493c6f43ea77749964"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.13/mtail_3.4.13_linux_amd64.tar.gz"
      sha256 "0817296e9609ed881f12eab1d93bac84e8aac2a156b6658a4ef86fa2fedf7b75"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
