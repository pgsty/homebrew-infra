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
      url "https://github.com/pgsty/farrow/releases/download/v0.8.0/farrow_0.8.0_darwin_arm64.tar.gz"
      sha256 "9ece0f58e7b820bb5831999c390e475aaec7e72b75ca3004cae0e6fb2109cd66"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.8.0/farrow_0.8.0_darwin_amd64.tar.gz"
      sha256 "00ad3f62ff2c29907bdd483aa801499ab1be4de43e2a5a9a6242074f63e49fdd"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/farrow/releases/download/v0.8.0/farrow_0.8.0_linux_arm64.tar.gz"
      sha256 "8c1440c0683e5e73b406fba2b702e5ff4dadc904897b51d4437298af229998a6"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/farrow/releases/download/v0.8.0/farrow_0.8.0_linux_amd64.tar.gz"
      sha256 "f6973c63a382d5cf416604fc81ff04bc7daca4701dcd81c80dbd866ffeca404b"
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
