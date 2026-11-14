# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.0/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "090758af021014c830661ec17c7b5467db1e911de17956361ee6b27551487325"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.0/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "1e68836b98c2599cd72dbefd7f501e598f760a533f6bc27127535fd1bcd45840"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.0/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1ff640f0d3800d72a04916e7b402f19e28e9106ed3ed719a876d238d9f73567"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.0/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62e6fdaf68f6ddfb45aa0dc1c28578a7e05f1e5e9a0c95fccfe1eae709d4ecbc"
    end
  end

  def install
    bin.install "stalwart"
    chmod 0755, bin/"stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
