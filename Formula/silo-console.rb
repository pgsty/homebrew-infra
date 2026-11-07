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
      url "https://github.com/pgsty/silo-console/releases/download/v2.6.0/silo-console-darwin-arm64", using: :nounzip
      sha256 "f6d2375eae9a390035214bb2713e8b9e2a2ae07cf2c9042b2ce24cdcbd1605bd"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.6.0/silo-console-darwin-amd64", using: :nounzip
      sha256 "11211bfff688f38a8a615624dd850c71ed9d4eadad65a512b5f7790ea3c65198"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.6.0/silo-console-linux-arm64", using: :nounzip
      sha256 "bfb466cf227cc55056878eb1426437a55cdf328bcec785687be34e064507ff19"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.6.0/silo-console-linux-amd64", using: :nounzip
      sha256 "53bb8395cb62803777e8cff2182592f8c90bbc71e9851cec1511a7d0fd0e92b6"
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
