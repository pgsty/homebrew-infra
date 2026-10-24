# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.27/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "08d47f26619b7a251b1d364bb639eff705bff24f916531a1ebdb1ba23d2e475a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.27/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "5b55fceea663ab5a3d08bf580bd5328a8c7ea8cf83623d7b4758d3f43c5b45a2"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.27/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "215301c8449e3bf8efd4c39cd557dc65dc37ec5bedab47f15c22ef24631100d7"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.27/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3d4548053e7130cdc6288134e28aecc5004f22549cc52a1dbda0ca48ff0b301a"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
