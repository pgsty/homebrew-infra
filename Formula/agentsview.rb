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
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_darwin_arm64.tar.gz"
      sha256 "9b9ad0e0966f53da8accec72b56431e69f5b7db72071df40699209c503b709e1"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_darwin_amd64.tar.gz"
      sha256 "52ce502f8723fc353eb24ddb0a509194ed4ae7d582e483aac5fd24d4b297e794"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_linux_arm64.tar.gz"
      sha256 "877ca0f8581251ba37c31b2a970a22bfca053fa6b142cd10063445def7a53348"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/kenn-io/agentsview/releases/download/v0.48.0/agentsview_0.48.0_linux_amd64.tar.gz"
      sha256 "4ea250e9de87530d2850ad3903185982db89a99b45d41363458e05cd18f5e5fc"
    end
  end

  def install
    bin.install "agentsview"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentsview --version 2>&1")
  end
end
