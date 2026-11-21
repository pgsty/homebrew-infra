# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.1/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "c5183bcd29f635cd7bbdf03714dd1974fec8e6557c1c0636be9d8c8e39ae7fd2"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.1/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "37cf083326fed8e931ffdc641a93a288398ac5b143cf69b62d0705f81e318361"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.1/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a278a105537f22a316b0f0653e4f263a0ebf0b8eddbac2e390cb2b87e8dba57b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v1.1.1/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e15ac79fbc9a80828bc6563bd1576245fcef66497ed5636d466a7f0c79912a19"
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
