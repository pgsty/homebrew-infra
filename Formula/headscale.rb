# typed: strict
# frozen_string_literal: true

class Headscale < Formula
  desc "Open source implementation of the Tailscale control server"
  homepage "https://headscale.net"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.5/headscale_0.29.5_darwin_arm64", using: :nounzip
      sha256 "e4f5ce794b7691a92d04a3dd9fb94ba259224021164c24bf01ad7dc83e8d76fe"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.5/headscale_0.29.5_darwin_amd64", using: :nounzip
      sha256 "6ddbcc54859cabfe13ac4ed6c481526251247165088d52622bc7bebc6240b8c1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.5/headscale_0.29.5_linux_arm64", using: :nounzip
      sha256 "3afddd207b89ac22cfad4235cc163c6e538cc59ada139e7c0bf47640c5d9e945"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.5/headscale_0.29.5_linux_amd64", using: :nounzip
      sha256 "e979d27fe17d924d33bb6ab7504f6338d0635989a0cfdcfbc0ceb637dbcbe980"
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
