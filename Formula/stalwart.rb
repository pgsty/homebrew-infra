# typed: strict
# frozen_string_literal: true

class Stalwart < Formula
  desc "Secure and scalable mail and collaboration server"
  homepage "https://stalw.art"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.20/stalwart-aarch64-apple-darwin.tar.gz"
      sha256 "4b4e7465e71d9e7992b773ec976a33eb6f4703001763432dba30de15c4ed1746"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.20/stalwart-x86_64-apple-darwin.tar.gz"
      sha256 "5141f69b9cd1edd1c012a005c7135abeb7f7e1610d65805456ca2307d112ad1b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.20/stalwart-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "82183ce973665d2b99822b4a1f9911a8ba14788fd73ee93ce9be92352ccdea64"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/stalwartlabs/stalwart/releases/download/v0.16.20/stalwart-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55184f166f89a0918c6523bb70be300370b63934357731b199dc26a12ca15abf"
    end
  end

  def install
    bin.install "stalwart"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stalwart --version 2>&1")
  end
end
