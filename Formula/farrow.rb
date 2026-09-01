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
      url "https://github.com/pgsty/farrow/releases/download/v0.2.0/farrow_0.2.0_darwin_arm64.tar.gz"
      sha256 "85dc9dacba98a3f9686593aed3887fae285df94a5ad4f1a9385c583cfd52e557"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.2.0/farrow_0.2.0_darwin_amd64.tar.gz"
      sha256 "8449a27285bbf58955892145f42daebaae24e8e2839d2990a2ada39205bbf3fd"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.2.0/farrow_0.2.0_linux_arm64.tar.gz"
      sha256 "e1d994ea8719d60d2c7b6b176d21d940e9590d6b0cac8800406ac5c158acee93"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.2.0/farrow_0.2.0_linux_amd64.tar.gz"
      sha256 "59eca62828302a40eecb0a677635b03c536ecb9c5ae9c35ce150661f0d198f03"
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
