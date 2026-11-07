# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.3/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "4d144d9f8e4be313b310b4db0baa9b184140d6a78b1491dc6e4c86934d0c2436"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.3/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "a51ae0ff8ab3447aed899459ddbc8ef43c99bfec89fa42299f25f2d9519b62a4"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.3/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b1e49a941ac38bb5e4e5586933dc736bdf5014b1892105a98e4cdf0bd829c461"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.3/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ae481ff410cd09dd53d7f49f528dcad35d90b4b2ffb0c49c9ae23aaf43c4831"
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
