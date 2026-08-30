# typed: strict
# frozen_string_literal: true

class SiloConsole < Formula
  desc "Administrative web console for Silo and MinIO servers"
  homepage "https://silo.pgsty.com"
  license "AGPL-3.0-or-later"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.2.1/silo-console-darwin-arm64", using: :nounzip
      sha256 "69b194281d4d7d35e90ae6c92b4003a18e2e1c4aa6b779cae36937c611be6e4b"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.2.1/silo-console-darwin-amd64", using: :nounzip
      sha256 "136fe608d5883f26640338a8726b0c444b211c361ccbaaa8aea3ce014a54b605"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.2.1/silo-console-linux-arm64", using: :nounzip
      sha256 "253ae2c4dc859b22dd9132f6c9427a5b122fa7766968c5ffb460cda6bb16b546"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.2.1/silo-console-linux-amd64", using: :nounzip
      sha256 "2babdd7af154c28691449d4d52d78d5e2b7d06fc4f6337281ccb04803bb98b13"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "silo-console-#{platform}-#{arch}" => "silo-console"
  end

  def caveats
    <<~EOS
      Start the console after configuring its target Silo/MinIO server:
        silo-console server --port 9001

      See https://silo.pgsty.com for the supported environment variables and
      production deployment guidance.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/silo-console --version 2>&1")
    assert_match "server", shell_output("#{bin}/silo-console server --help 2>&1")
  end
end
