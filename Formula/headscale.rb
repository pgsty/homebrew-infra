# typed: strict
# frozen_string_literal: true

class Headscale < Formula
  desc "Open source implementation of the Tailscale control server"
  homepage "https://headscale.net"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.3/headscale_0.29.3_darwin_arm64", using: :nounzip
      sha256 "fb55b6d3d1ef3b850fe02837299ac1853f383a06f561d7f180d36b9ce406904b"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.3/headscale_0.29.3_darwin_amd64", using: :nounzip
      sha256 "7c05dba42948d5ba67c281c9cc5b3a9e33d0db4198580ec8b483bdc7f6008dde"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.3/headscale_0.29.3_linux_arm64", using: :nounzip
      sha256 "ecf0099f9aa1efb56e7c74718342a493f7d44a840626a2877ca526e675040f4e"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.3/headscale_0.29.3_linux_amd64", using: :nounzip
      sha256 "8dc183758024ed7095cf610fedea0790233613c71353bc8be2715d82ba29b92c"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "headscale_#{version}_#{platform}_#{arch}" => "headscale"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/headscale version 2>&1")
  end
end
