# typed: strict
# frozen_string_literal: true

class Headscale < Formula
  desc "Open source implementation of the Tailscale control server"
  homepage "https://headscale.net"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.4/headscale_0.29.4_darwin_arm64", using: :nounzip
      sha256 "b5cfd0f81caaa1e8f71f830fd89fdf86a8719bb6e9f9a2ec5b47d9426c96986e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.4/headscale_0.29.4_darwin_amd64", using: :nounzip
      sha256 "06e4c94a8b9397ed8c2714a4cd484c998604dc884e9b5d4a186aef05f14047b1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.4/headscale_0.29.4_linux_arm64", using: :nounzip
      sha256 "cbad8f02524cc6a94955a107a72e1d4cc652ae3f22e740d5c60884e7f384d60e"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.4/headscale_0.29.4_linux_amd64", using: :nounzip
      sha256 "212ed0a884c0d3541e094c4bebbe94397df6f4e01bd3d7f059c520cb55e0d757"
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
