# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.2.0/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "7c06bbdff6d3e9ee83d31a2d9ceb21f6dd69173970c57a84870740b326491b26"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.2.0/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "80f9013e4fb21ace5137a002fead5663c03c22308d1a1c7db3e44eddd4a89c0e"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.2.0/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "51729601c4e3957045ec2abb556f58b418df152923065d96d13324cee5f6dd02"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.2.0/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ee79b1552acc3c89e4354405c7a716874826e4db7537a4b32c7b1677e08688c8"
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
