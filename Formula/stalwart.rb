# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.1/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "338cfe81fd83c6724d364609a32b2229ed0cc09c6b1330c278ff1d7964d1f82f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.1/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "1be63aac81470217b48fda51f0c85ba0409a113bd8c41514189f4a2d2962da84"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.1/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "36612d5c4e7c11b23a87b205c9341be08eb49c71515d4720854e1864b7e4c5b5"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.1/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aabae69bcdeff31e305d60f3ecb059fdb203116c0077d81560bf6d6f0f757d75"
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
