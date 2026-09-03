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
      url "https://github.com/pgsty/silo-console/releases/download/v2.3.0/silo-console-darwin-arm64", using: :nounzip
      sha256 "6148faa048ed6d0206e49aff712061b461852421828a8c7abde801e55c5d0558"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.3.0/silo-console-darwin-amd64", using: :nounzip
      sha256 "056f052761bfc2c8158f2d4228ccc936efcec4fa7499f792bc2d63c9328a2557"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.3.0/silo-console-linux-arm64", using: :nounzip
      sha256 "3ebf437f88f12516787f810781dc8d1e272f93531ca109f6a76bd47a399e6c8f"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.3.0/silo-console-linux-amd64", using: :nounzip
      sha256 "f6f8f758c2c8b3d9d96d5450fa8a237bf73866f16c96ca50abe1240725b0dc03"
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
