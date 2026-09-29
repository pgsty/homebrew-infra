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
      url "https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_darwin_arm64.tar.gz"
      sha256 "0640a6dc5d8f8027be10c54e6ded7c97ab7c8c7c511017d6417c5cc87f064153"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_darwin_amd64.tar.gz"
      sha256 "6b8ba87f42ec3a930a9d506e805d094f408fd602c5bd962be2afcbccdd334d0a"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_arm64.tar.gz"
      sha256 "f2198b03655b7f320ce57e29868570d8740133102388474bbfbf1acdc39c2275"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.0/barn_0.9.0_linux_amd64.tar.gz"
      sha256 "4053280496b5dabb5fc25667069b45146e636b1ceccb0e27c1eca42fd8e00a13"
    end
  end

  def install
    bin.install "bin/barn"
    libexec.install "bin/barn-hosts-helper"
    if (buildpath/"bin/Barn Mac.app").directory?
      libexec.install "bin/Barn Mac.app"
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
    return text unless (libexec/"Barn Mac.app").exist?

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
