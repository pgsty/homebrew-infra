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
      url "https://github.com/pgsty/farrow/releases/download/v0.4.0/farrow_0.4.0_darwin_arm64.tar.gz"
      sha256 "c94911526369996d1bbae2a942a94a002e9bfa4a73e58bbeb1bf3455552b56e1"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.4.0/farrow_0.4.0_darwin_amd64.tar.gz"
      sha256 "6958fcf3ba29af69b282863486f2ca400e7eb012da019c4a6e73d9215e6934ef"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.4.0/farrow_0.4.0_linux_arm64.tar.gz"
      sha256 "cda917854ea40a94fa97ef0dfb133f8110b9e554b780d61906db9b9dba9005da"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.4.0/farrow_0.4.0_linux_amd64.tar.gz"
      sha256 "e9a8588cb3649c22ed6290c59dfe7f36bd0b1f73a3de4e04e5cad9a96c9b71f9"
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
