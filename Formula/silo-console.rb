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
    depends_on macos: :ventura

    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.5.1/silo-console-darwin-arm64", using: :nounzip
      sha256 "51b0fc0c4d47631893e516b304f7088bbae484c4dcd9702f6ef5ae947a5de2eb"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.5.1/silo-console-darwin-amd64", using: :nounzip
      sha256 "bca5c478760c72c28618e5619126bd78c14cc65fedbaec8a480e18b0afa5f001"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.5.1/silo-console-linux-arm64", using: :nounzip
      sha256 "a3de5431afbda577959a775124cf6a9aa7f845721f385fc9077104f0472791d3"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.5.1/silo-console-linux-amd64", using: :nounzip
      sha256 "b7bf4c8ae0bfbbad74af981cbecefab7af970c790fd4a2efbe524cc0383fa0aa"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "silo-console-#{platform}-#{arch}" => "silo-console"
    chmod 0755, bin/"silo-console"
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
