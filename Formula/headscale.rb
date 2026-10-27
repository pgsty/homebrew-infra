# typed: strict
# frozen_string_literal: true

class Headscale < Formula
  desc "Open source implementation of the Tailscale control server"
  homepage "https://headscale.net"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.6/headscale_0.29.6_darwin_arm64", using: :nounzip
      sha256 "d63767d67aec7521b7dd8602a7c28ce9d36d21de3a8025b37b71c81cbbe14109"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.6/headscale_0.29.6_darwin_amd64", using: :nounzip
      sha256 "9ec1905cf13bc875ed9ba4e3e371edcb0440b267aa4667a2143fc85a544a81c4"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.6/headscale_0.29.6_linux_arm64", using: :nounzip
      sha256 "7b3c792ebe10e1a81a0c8d9674aee8eb540e7dbb7ccb80a98b71024da4c72a48"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.6/headscale_0.29.6_linux_amd64", using: :nounzip
      sha256 "7477c374949eea6fb7cf3cbff14dbef49e4d118d9a33557d6764a77ece617e53"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "headscale_#{version}_#{platform}_#{arch}" => "headscale"
    chmod 0755, bin/"headscale"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/headscale version 2>&1")
  end
end
