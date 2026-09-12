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
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.0/silo-console-darwin-arm64", using: :nounzip
      sha256 "2254ba6b0e362409fef0e3bc197ddae6400f242623973b144b268f06ae031992"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.0/silo-console-darwin-amd64", using: :nounzip
      sha256 "5a772ce0185a7f53115cbfd48895605ce43c192ae046caf4b061d9949f9b4f90"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.0/silo-console-linux-arm64", using: :nounzip
      sha256 "2d789a08bb3ea079b3157ba798deb9cd051ce201c55d96e7121552ed4f682401"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/silo-console/releases/download/v2.4.0/silo-console-linux-amd64", using: :nounzip
      sha256 "a9a070e54b95742cf558cd86744fe99ab51bd0f5764eaf06ffb25012853a6cb4"
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
