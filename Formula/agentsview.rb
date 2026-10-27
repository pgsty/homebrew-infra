# typed: strict
# frozen_string_literal: true

class Agentsview < Formula
  desc "Browse, search, and track costs across AI coding agents"
  homepage "https://github.com/kenn-io/agentsview"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.1/agentsview_0.46.1_darwin_arm64.tar.gz"
      sha256 "83cd9872acf5bf59e77c149504431e317eed74537169a27f48d732db6f941415"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.1/agentsview_0.46.1_darwin_amd64.tar.gz"
      sha256 "ed83679fc6ddcee02f1f66490ba0902fd8710dbf2bd5bb45172737dacbd340ea"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.1/agentsview_0.46.1_linux_arm64.tar.gz"
      sha256 "b170c7a70fab2c5d6297515b0f972aa3b43e1f3a677e7cc6b450d64ca730fb02"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.46.1/agentsview_0.46.1_linux_amd64.tar.gz"
      sha256 "e7822006d7bafa3aef9a5e4f7d7caffca56051bb039b848222a73633ed4c6c9b"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
