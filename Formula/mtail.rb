# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.20/mtail_3.4.20_darwin_arm64.tar.gz"
      sha256 "09e22ffc6fb0299f38b6c4a13e1526a85df3f85d2433cec11405a8c084cd1b73"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.20/mtail_3.4.20_darwin_amd64.tar.gz"
      sha256 "bae6212c8ed7d7c0869125c7a3a3082a2c04ea51d3fa4524fb72396b2417d7be"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.20/mtail_3.4.20_linux_arm64.tar.gz"
      sha256 "d6c47cc000e921e294dc00453584958b8f2875f75db225a7873778ed42b4bf6a"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.20/mtail_3.4.20_linux_amd64.tar.gz"
      sha256 "771d5ea22c53ec4c1eb9932a27b91fdacc2d0c8a7c7f94d516437e78f7e69dd5"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
