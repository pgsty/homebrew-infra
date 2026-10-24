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
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.2/silo-console-darwin-arm64", using: :nounzip
      sha256 "335b607050a0b06979b156e0498d0bc7252a4b08e6b26fe87ce791b7d25dd016"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.2/silo-console-darwin-amd64", using: :nounzip
      sha256 "062b877eba2ff247e2ef036a632b2300fa4021c800c167244998fab830eae7ee"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.2/silo-console-linux-arm64", using: :nounzip
      sha256 "0f54c30e048b4ecf9f1dff8cb3c0361be26a1bd6685dcbc6dbb06a9eeeeb8fea"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.2/silo-console-linux-amd64", using: :nounzip
      sha256 "32806829cf11a4c681c29573694f9b337bd9d78e027227d3c7ee4e567df8b610"
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
