# typed: strict
# frozen_string_literal: true

class Barn < Formula
  desc "Native Go/QEMU runtime for Pigsty development VMs"
  homepage "https://barn.pgsty.com"
  license "Apache-2.0"
  head "https://github.com/pgsty/barn.git", branch: "main"

  depends_on "go" => :build
  depends_on "qemu"

  def install
    ENV["BARN_VERSION"] = "HEAD"
    system "make", "build"
    bin.install (buildpath/"bin/barn").realpath => "barn"
    libexec.install (buildpath/"bin/barn-hosts-helper").realpath => "barn-hosts-helper"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      Start your first VM from a terminal:
        barn up
        barn ssh

      For unattended host preparation, run barn setup --yes first.
    EOS
  end

  test do
    assert_match "barn HEAD", shell_output("#{bin}/barn version")
    helper_sha256 = Digest::SHA256.file(libexec/"barn-hosts-helper").hexdigest
    assert_match helper_sha256, File.binread(bin/"barn")
  end
end
