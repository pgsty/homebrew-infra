# typed: strict
# frozen_string_literal: true

class Farrow < Formula
  desc "Native Go/QEMU runtime for Pigsty development VMs"
  homepage "https://farrow.pgsty.com"
  license "Apache-2.0"

  depends_on "qemu"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.5.0/farrow_0.5.0_darwin_arm64.tar.gz"
      sha256 "67646535f3521ce5aea8c38cc57ae3f5b5624f41d168150bce71f979d8b6b4f8"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.5.0/farrow_0.5.0_darwin_amd64.tar.gz"
      sha256 "c7e772364443243837bc33be7d6c65fcd5ad6ef6c24fed730f738bdf89f57d45"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.5.0/farrow_0.5.0_linux_arm64.tar.gz"
      sha256 "846fc908a0c3f0b4bd1b2faef01620b1d1f5d0b954c8b7b3dc71c8ab791bfd9f"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.5.0/farrow_0.5.0_linux_amd64.tar.gz"
      sha256 "c28b6109d36eaed127c56742a72ca1b7aa31c79dbb622de2ea8ce27a67482359"
    end
  end

  def install
    bin.install "bin/farrow"
    libexec.install "bin/farrow-hosts-helper"
    doc.install "README.md", "licenses"
  end

  def caveats
    <<~EOS
      Prepare the host once, then start a lab:
        farrow setup
        farrow up

      Farrow setup installs or reuses its private host network and asks for
      administrator access only when the host transaction requires it.
    EOS
  end

  test do
    assert_match "farrow #{version}", shell_output("#{bin}/farrow version")
  end
end
