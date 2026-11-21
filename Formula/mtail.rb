# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.21/mtail_3.4.21_darwin_arm64.tar.gz"
      sha256 "e242c747df9f3bc657540c38b8af4425836722de1d939a48b1b6d6f17c0a37fb"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.21/mtail_3.4.21_darwin_amd64.tar.gz"
      sha256 "9b3bc90b66ff9a1ed96ed1645a782d2a3da96f4cb66ef71269b95483f7e39df6"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.21/mtail_3.4.21_linux_arm64.tar.gz"
      sha256 "feca10316e23c97b258c98149f59cdf4cd30e5b7ccfacc433300c4246507f8e2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.21/mtail_3.4.21_linux_amd64.tar.gz"
      sha256 "1e1fafaa0d440c63776e89062bca3b53579d93b979428014d817860ddda6682a"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
