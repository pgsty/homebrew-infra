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
      url "https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console-darwin-arm64", using: :nounzip
      sha256 "f99831e4c7a5ad55511b58e41193b90672068ad0c1c5b3f94ee0751d59ecbda5"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console-darwin-amd64", using: :nounzip
      sha256 "3af0134c26bce73ae2e9b6c458e730879ce19ed88903be858c4cf08e3a0c66d5"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console-linux-arm64", using: :nounzip
      sha256 "95bf36ec5342a7838df350d993546fab6af252d7c4de3c2e05ed6875c2918a59"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.7.2/silo-console-linux-amd64", using: :nounzip
      sha256 "dbaff1563ba6967a6a5bb6e160077f70ce7831b26487db3c416644e9012cc8d7"
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
