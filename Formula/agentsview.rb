# typed: strict
# frozen_string_literal: true

class Agentsview < Formula
  desc "Browse, search, and track costs across AI coding agents"
  homepage "https://github.com/kenn-io/agentsview"
  license "MIT"

  on_macos do
    depends_on macos: :tahoe

    on_arm do
      # update: darwin_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_darwin_arm64.tar.gz"
      sha256 "7fb2747410d8d2941912414e968ccca33b0a67166270d4fa17e8ff88ec207f8f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_darwin_amd64.tar.gz"
      sha256 "943072df90a6b6ce5d3263f16b9e40fbdc2d77302aacc5c1af825c85524a38ad"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_linux_arm64.tar.gz"
      sha256 "587936c600ecef1a0b18ecabf384c75c4ea503c37f9032ef1117c023544edeaa"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.47.0/agentsview_0.47.0_linux_amd64.tar.gz"
      sha256 "a49876edf9fe8d0641978afe69d776540175852a446a5d42a6d439215eb0dc45"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
