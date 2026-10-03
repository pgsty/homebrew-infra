# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.24/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "1af63fff943ce5d0840535460ad3df30f6f493e6ce6cfce6fd2e52ac7cc26cfc"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.24/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "3f21b0d59d77a2bb8541431e509ea1a0c2e38d71e913b7d24883487864e0449f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.24/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e025971a6591d7a3fb81883c556d038fa246ee8164ebda0a2fa682e5d317650"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.24/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "51392691d4ab67864e84af5215277dbd4a069ffaf9a0ceb94a07462e22487843"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
