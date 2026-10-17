# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.26/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "0782ddaec67cd4dd15b5c78f3c2819dca4d3cd4cf19412d2773cf166bc7759f1"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.26/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "0035a917463b059214b6f6b50edc18f55b03356fa487c1f894323320c5dad18d"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.26/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "baa581231f7b4a53bfee900f7e186b5cf4605874558a62983e3888d0c70fa7c9"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.26/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed5095fffd8b6addf8d8424c06a574948172716e05f52f394ddfef3fc2bd2211"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
