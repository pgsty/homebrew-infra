# typed: strict
# frozen_string_literal: true

class Agentsview < Formula
  desc "Browse, search, and track costs across AI coding agents"
  homepage "https://github.com/kenn-io/agentsview"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.45.0/agentsview_0.45.0_darwin_arm64.tar.gz"
      sha256 "c2b5a24d4fc4455a656c54f16b0e281f894c648f8a039fa52e76a47e1e18315b"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.45.0/agentsview_0.45.0_darwin_amd64.tar.gz"
      sha256 "2059c7dbee622771e0cb9c7b4850e04d93654214ee0148fb8d28cbd03255bc85"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.45.0/agentsview_0.45.0_linux_arm64.tar.gz"
      sha256 "9910fed1c41582901bfc2ed8ca5844d02605d472936f976843382c4e8031c6eb"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.45.0/agentsview_0.45.0_linux_amd64.tar.gz"
      sha256 "ff990fa6b1cd4300bd28e0defa90bc8261ef3f760f2d584112d7a0a6596a5313"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
