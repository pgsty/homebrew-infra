# typed: strict
# frozen_string_literal: true

class Pggo < Formula
  desc "PostgreSQL command-line client with JSON output"
  homepage "https://github.com/pgrundev/pggo"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgrundev/pggo/releases/download/v0.1.1/pggo_0.1.1_darwin_arm64.tar.gz"
      sha256 "fce37a5319bc2fa51d6525a6c1f6a94724daad53e7a3641e9eb3d914252b1b71"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgrundev/pggo/releases/download/v0.1.1/pggo_0.1.1_darwin_amd64.tar.gz"
      sha256 "2bfa7fb666a0aadf6ee6fd4043c79619efe4885d344ac9cbb945b2bb42c71def"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgrundev/pggo/releases/download/v0.1.1/pggo_0.1.1_linux_arm64.tar.gz"
      sha256 "c5fc2e474be37c8f83141b6929e65a67a0e215b18f338df50ee7129c323dc1a1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgrundev/pggo/releases/download/v0.1.1/pggo_0.1.1_linux_amd64.tar.gz"
      sha256 "2a20314fff9ea224cd1192e8c3eaab29ac8fc1a17620353662e036c95f569635"
    end
  end

  def install
    bin.install "pggo"
    doc.install "README.md"
  end

  test do
    output = JSON.parse(shell_output("#{bin}/pggo version"))
    assert_equal true, output["ok"]
    assert_equal version.to_s, output["version"]
    help = JSON.parse(shell_output("#{bin}/pggo help"))
    assert_equal "pggo", help["name"]
    assert help["commands"].key?("query")
  end
end
