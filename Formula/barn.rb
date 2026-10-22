# typed: strict
# frozen_string_literal: true

# Barn installs the unprivileged native QEMU development-VM runtime.
class Barn < Formula
  desc "Native Go/QEMU runtime for Pigsty development VMs"
  homepage "https://barn.pgsty.com"
  license "Apache-2.0"

  depends_on "qemu"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_darwin_arm64.tar.gz"
      sha256 "6a182a62d5aad3ce417fba99a0041ef9495eae5cb74d41760e51bfe2a1e593ec"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_darwin_amd64.tar.gz"
      sha256 "46d5e542d0c570f22401c5b69b5f9975fcbc3d42337aeecf00f18c1ff07a1301"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_arm64.tar.gz"
      sha256 "d5c74cd6329003f040b7e408dcdd17836ec4882373f3de266604064e16922acf"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.1/barn_0.9.1_linux_amd64.tar.gz"
      sha256 "bb921a0b9279e00575bbc2c8343ab4e8ca0c3c05f17e4d42e7b6964fd8123a7b"
    end
  end

  def install
    bin.install "bin/barn"
    libexec.install "bin/barn-hosts-helper"
    if (buildpath/"bin/Barn.app").directory?
      libexec.install "bin/Barn.app"
      doc.install "MACOS.md", "MACOS.json"
    end
    doc.install "README.md"
    doc.install "licenses"
  end

  def caveats
    text = <<~EOS
      Start your first VM from a terminal:
        barn up
        barn ssh

      Up reuses your inventory or current lab, and creates a one-node
      barn.yml when neither exists. It prepares the host when needed and
      asks for administrator access at the privileged step.
      Use barn init full to customize a four-node lab before starting it.
      For unattended preparation, run barn setup --yes before barn up.
    EOS
    return text unless (libexec/"Barn.app").exist?

    text + <<~EOS

      On Apple Silicon with macOS 27 or later, start a macOS guest with:
        barn mac up
        barn mac open
    EOS
  end

  test do
    assert_match "barn #{version}", shell_output("#{bin}/barn version")
  end
end
