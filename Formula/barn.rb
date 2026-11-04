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
      url "https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_darwin_arm64.tar.gz"
      sha256 "72a82e8b7cca1fdbdbacba4cc34ebe4b0993f2ad9289b8eff0e23b4c519e6959"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_darwin_amd64.tar.gz"
      sha256 "11655e1a827e6a84a8b5340bfb811603644c54e8a0444bb249fc90070c1420c0"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_arm64.tar.gz"
      sha256 "655c265a33d438d46a4a686e33be6d4380765405e10c66454cfd7a835e57a49b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/barn/releases/download/v1.0.0/barn_1.0.0_linux_amd64.tar.gz"
      sha256 "f97e2dcd911b500fab18584801c8c973bb23fcabbc7c89376d775c918e6dbf96"
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
