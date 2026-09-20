# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.22/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "224f8752f6f825831369b40676f8dfc3cdf1166229827d6fd0efe85123268628"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.22/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "9d41574874306f8fcf3bde2879980e1dc8582424db09952905f8f6e1d99a84b4"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.22/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b041ae97fdf5c28fd32c067a5c6475c0520e16765c5dfc789c15dac5c603053"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.22/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "951872325f3d4d85f9d33db08d34836aabeffb9346a2d59b2643289b7aab6ff8"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
