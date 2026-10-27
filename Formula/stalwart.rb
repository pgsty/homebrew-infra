# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.0/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "38097ad18a61c20829a21d8b8fdc4b630e4f1b756d821175906cf75e32094a40"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.0/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "571a41db3e963f290e2990a3a545560dd52e7638945393bea56aa1efe9fe0713"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.0/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98e4ecd9dea8bbb5e0f8a807921a1f5f1f67a94f70e58801e90999bb63f4c9d0"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.0.0/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "433a00fc67e85e6eda4729954352a67bfc639c02502de421a69364e86b989a94"
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
