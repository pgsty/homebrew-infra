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
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.1/silo-console-darwin-arm64", using: :nounzip
      sha256 "80b9116faf64c7cb5c6f8f4759903ccb613ae49d1855070f1101f688cbf85eee"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.1/silo-console-darwin-amd64", using: :nounzip
      sha256 "9301ac46d848adc22812496aac71fd8a84d4c70eb6404939cd8e78211c76b3b0"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.1/silo-console-linux-arm64", using: :nounzip
      sha256 "b5028057511cf5104ce2e161bf2faf80b3401b9d081e57e787b1c47ce5f701bc"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.1/silo-console-linux-amd64", using: :nounzip
      sha256 "c5269d88a56d4af7c75d1c861e3acfa4ad72cac805f7e9c3d6ecd934f09accb1"
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
