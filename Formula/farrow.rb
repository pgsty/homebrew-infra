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
      url "https://github.com/pgsty/farrow/releases/download/v0.6.0/farrow_0.6.0_darwin_arm64.tar.gz"
      sha256 "48957843e68b979580a214133bc8fd59c3962f47304c7d3274b8e49106e53637"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.6.0/farrow_0.6.0_darwin_amd64.tar.gz"
      sha256 "d685b6d3b997c6ec0105d002e8d00205a603b30a48c56e4c40d4d966a1b2095a"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.6.0/farrow_0.6.0_linux_arm64.tar.gz"
      sha256 "091d5798ac03e9d726f024750efe142438ec63e065ede9e03c2ac0f4029978b4"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.6.0/farrow_0.6.0_linux_amd64.tar.gz"
      sha256 "9d0da7099fcb9d826384d5580f9ee781b3f46f15a7698c09c5cf7e5c66f5835b"
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
