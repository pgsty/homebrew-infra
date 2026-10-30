# typed: strict
# frozen_string_literal: true

# Barn installs the unprivileged QEMU development-VM runtime and its optional
# signed native macOS guest component.
class Barn < Formula
  desc "Go/QEMU runtime for Pigsty development VMs"
  homepage "https://barn.pgsty.com"
  license "Apache-2.0"

  depends_on "qemu"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/barn/releases/download/v0.9.2/barn_0.9.2_darwin_arm64.tar.gz"
      sha256 "3f914c62b42eb23425cf42458f0d54812df7921216bd0939ded54ad607dac8cd"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.2/barn_0.9.2_darwin_amd64.tar.gz"
      sha256 "2a6ff2875a10fb165a68b1a2b3c3a8e7c6fd350e5dd91f9c2aae5049c7de7e4b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/barn/releases/download/v0.9.2/barn_0.9.2_linux_arm64.tar.gz"
      sha256 "9ec73837a5c29bc7c5f0ad863d8f93ebc3271c08a6ba9e66d601bf60e33db644"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/barn/releases/download/v0.9.2/barn_0.9.2_linux_amd64.tar.gz"
      sha256 "de8145d1e5f9792844bf3feb0fa756b79c635fc78b83ca12a7b1b949504b4830"
    end
  end

  def install
    bin.install "bin/barn"
    libexec.install "bin/barn-hosts-helper"

    app = buildpath/"bin/Barn.app"
    if app.directory?
      if bundled_mac_component_required? && !native_component_metadata_valid?(buildpath)
        odie <<~EOS
          The Barn #{version} native component is not a Developer ID signed,
          notarized release. Refusing to install an incomplete macOS VM bundle.
        EOS
      end
      libexec.install app
      doc.install "MACOS.md", "MACOS.json"
    elsif bundled_mac_component_required?
      odie <<~EOS
        The Barn #{version} Apple Silicon archive is missing Barn.app.
        This release cannot provide macOS VM support through Homebrew.
        Use a release with the signed, notarized native component.
      EOS
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
    unless (libexec/"Barn.app").directory?
      return text if !OS.mac? || !Hardware::CPU.arm?

      return text + <<~EOS

        This Barn release does not bundle Barn.app, so it cannot run macOS
        guests. Upgrade to a release that includes the signed native component.
      EOS
    end

    text + <<~EOS

      On Apple Silicon with macOS 27 or later, start a macOS guest with:
        barn mac up
        barn mac open
    EOS
  end

  def bundled_mac_component_required?
    # 0.9.1 is the last public CLI-only release; 0.9.2+ carries Barn.app.
    OS.mac? && Hardware::CPU.arm? && version >= "0.9.2"
  end

  def native_component_metadata_valid?(root)
    manifest = root/"MACOS.json"
    return false unless manifest.file?

    metadata = JSON.parse(manifest.read)
    metadata.is_a?(Hash) && metadata["signing"] == "developer_id" &&
      metadata["notarized"] == true && metadata["target"] == "darwin/arm64"
  rescue JSON::ParserError
    false
  end

  test do
    assert_match "barn #{version}", shell_output("#{bin}/barn version")
    assert_path_exists libexec/"barn-hosts-helper"

    if OS.mac? && Hardware::CPU.arm?
      app = libexec/"Barn.app"
      if app.directory?
        assert_path_exists app/"Contents/MacOS/barn-mac-runner"
        assert native_component_metadata_valid?(doc)
        system "/usr/bin/codesign", "--verify", "--strict", bin/"barn"
        system "/usr/bin/codesign", "--verify", "--strict", libexec/"barn-hosts-helper"
        helper_sha = Digest::SHA256.file(libexec/"barn-hosts-helper").hexdigest
        assert_match helper_sha, (bin/"barn").binread, "CLI does not match its signed hosts helper"
        system "/usr/bin/codesign", "--verify", "--deep", "--strict", app
        signature = shell_output("/usr/bin/codesign --display --verbose=2 #{app} 2>&1")
        assert_match "Authority=Developer ID Application:", signature
      elsif bundled_mac_component_required?
        flunk "Barn #{version} must install the signed native macOS component"
      end
    end
  end
end
