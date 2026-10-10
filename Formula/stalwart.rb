# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.25/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "777fb2896d7704a647062fdec989cacfb10997114ac7d30256c37e882c37f874"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.25/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "a98b2c2e3e8b600445302e60452c9d2122b961351f168f24ed6aa95d82b9b9f0"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.25/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7fc867e8bac70e00c372e8c8e8bc0e73e5f367f797daa5446f8c79225bdfb7e1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.25/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ba9cc0ea2795121df5c1264af41e82353c5a3d6860161c4ab70817906d912d3"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
