# typed: strict
# frozen_string_literal: true

class Agentsview < Formula
  desc "Browse, search, and track costs across AI coding agents"
  homepage "https://github.com/kenn-io/agentsview"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_arm64.tar.gz"
      sha256 "f0c8bde6d32596b87cd8b6f99a770ae866e8512979d4d2b701426b3ede37a92c"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_darwin_amd64.tar.gz"
      sha256 "b9300f893dce4912cf65f849553b0f33f2e5021baba858b5fb9847af3017ad98"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_linux_arm64.tar.gz"
      sha256 "8826c77f94197dfb995214f7b91ea9e60aa05cf42ca4a2e0594211a801ecf560"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.41.1/agentsview_0.41.1_linux_amd64.tar.gz"
      sha256 "0c326ca59cc4efa66676064288639bd1d93f6913d948fde42b51f0dc8e77bdd4"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
