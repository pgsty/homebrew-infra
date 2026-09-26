# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.23/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "ccab39449b63443f62c433af8baf95e8317c9a7dea993d84e588b2900372414e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.23/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "decde83d6d645e4e8a7677f06593308df85e1d25da1a78139205534db2aec596"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.23/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "49a389af64ba50f9777b9ed40a6298e885fba54be25ed7cdfa644b8f447556bf"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.23/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "967dfad2bed7ee7b475e78dfcf2f75bbfc30c851afb7d5951b0a80f2061cd3d4"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
