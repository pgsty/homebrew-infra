# typed: strict
# frozen_string_literal: true

class Headscale < Formula
  desc "Open source implementation of the Tailscale control server"
  homepage "https://headscale.net"
  license "BSD-3-Clause"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.7/headscale_0.29.7_darwin_arm64", using: :nounzip
      sha256 "1c2e772f35a61142a1582fba5e8919adaeace9a9b2abddd039f9872141585df0"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.7/headscale_0.29.7_darwin_amd64", using: :nounzip
      sha256 "9e82977644388d4a61d460d6ff7d8207f4894dea9fc02e75c9d8f23576bf360b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.7/headscale_0.29.7_linux_arm64", using: :nounzip
      sha256 "4357b38ac63c1e425f190819fd2ee078f13e01a6d7559b15811154e2475df5e4"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/juanfont/headscale/releases/download/v0.29.7/headscale_0.29.7_linux_amd64", using: :nounzip
      sha256 "e827fc9b12d958bc95b081c4401dd63f8e0471d025b45b508535a920532150a8"
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
