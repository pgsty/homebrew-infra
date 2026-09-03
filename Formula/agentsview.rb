# typed: strict
# frozen_string_literal: true

class Agentsview < Formula
  desc "Browse, search, and track costs across AI coding agents"
  homepage "https://github.com/kenn-io/agentsview"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.42.0/agentsview_0.42.0_darwin_arm64.tar.gz"
      sha256 "57f437a089f2f9d41c7335d7ce2a96f2ba95a11d4517678c6a6866a65390a3f3"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.42.0/agentsview_0.42.0_darwin_amd64.tar.gz"
      sha256 "adf3ce82a10da289c75eaa07e8287f8f40d8d3e25cbcfcbb3b489401b0807957"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.42.0/agentsview_0.42.0_linux_arm64.tar.gz"
      sha256 "c148ef8c8bc9715e2c351c1bf726135479b5e778693f86ade69200e1ebcc09ca"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.42.0/agentsview_0.42.0_linux_amd64.tar.gz"
      sha256 "f2b8a278b60776ee8edb745cb5bb3da2b5de57271b49a69d94af4fa2bdb17414"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
