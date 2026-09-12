# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.21/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "317f0f87208c04364518d987db427e8cb3700b5bc56356a999f5c982808d2bb5"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.21/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "fb493d420d900245eecbb2769085bb29426f2670792e2009faec0f4da184bdac"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.21/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "00df357526af2e482d4b04c14f21d9fe9a1e7612ce6ea19e01c674176c83d606"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.21/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb02fb00b2aa320a3ec1fa32560689ad7141033711931b0b0165e4b7145d0003"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
