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
      url "https://github.com/pgsty/farrow/releases/download/v0.1.0/farrow_0.1.0_darwin_arm64.tar.gz"
      sha256 "c18f5fa9499c89d8a29e78630f29a1378fd74f5d59716660b1173186d62f3580"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.1.0/farrow_0.1.0_darwin_amd64.tar.gz"
      sha256 "d9fd70c4e43a4f7ff1d502646acb8b62509386ca3212f91bb17cb3178f3285ec"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.1.0/farrow_0.1.0_linux_arm64.tar.gz"
      sha256 "823b0d76aec440354581f7e2c0b369ea56eec5902d300a1def572dbdc2be2ca2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.1.0/farrow_0.1.0_linux_amd64.tar.gz"
      sha256 "f860d8ecab3da7726149f1786fc12a2ae1ac501ff8a10697b05dded3d3afc3b5"
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
