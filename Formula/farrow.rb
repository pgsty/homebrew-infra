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
      url "https://github.com/pgsty/farrow/releases/download/v0.7.0/farrow_0.7.0_darwin_arm64.tar.gz"
      sha256 "63b16088400279dbb4da6b95e9cde27f44b523a76ad93d388d65ecdd641d0ae0"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.7.0/farrow_0.7.0_darwin_amd64.tar.gz"
      sha256 "dd62d7cd1f8335e021c81367489c64c3706f0a99ab669fd5324dbbd469cfcbf1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.7.0/farrow_0.7.0_linux_arm64.tar.gz"
      sha256 "dff60de60249e0a8b239fedbab0c90e750fb744d962dbdc33dd48e82162fc8c2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.7.0/farrow_0.7.0_linux_amd64.tar.gz"
      sha256 "c412e89d89a64aea1cf886e02f5b023e7f8154bcd8d6a40625f62a879a2beca8"
    end
  end

  def install
    bin.install "bin/farrow"
    libexec.install "bin/farrow-hosts-helper"
    doc.install "README.md", "licenses"
  end

  def caveats
    <<~EOS
      Start a lab from an empty directory:
        farrow up
        farrow ssh

      Interactive `up` creates the default inventory and offers to prepare
      missing host dependencies. Repeat `farrow up` to retry unfinished guest
      setup without restarting healthy VMs. For unattended setup, use
      `farrow setup --yes` before `farrow up`.

      Farrow treats data disks as disposable test storage: an unusable
      filesystem, including a persistent disk, may be reset and reported as
      data loss. Keep valuable data outside the lab disks.
    EOS
  end

  test do
    assert_match "farrow #{version}", shell_output("#{bin}/farrow version")
  end
end
