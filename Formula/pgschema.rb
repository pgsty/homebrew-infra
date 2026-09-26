# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.1/pgschema-1.13.1-darwin-arm64", using: :nounzip
      sha256 "15af7abf0b7e545a98452f2eed62650a7dc8aa6abcc7f54dd4f0f6e234238a43"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.1/pgschema-1.13.1-darwin-amd64", using: :nounzip
      sha256 "72d26778679407cec0816d1ec26fb123d2fd80120817977051c53e86b6afced5"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.1/pgschema-1.13.1-linux-arm64", using: :nounzip
      sha256 "8202d3e2cba000872627472549dbfb4618d2b256b22e7144b4ff6ecd476f36c1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.1/pgschema-1.13.1-linux-amd64", using: :nounzip
      sha256 "f726513e19d12f7667ba0b6a24e7a3a568e576708de030ef88f4ba3790e85946"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "pgschema-#{version}-#{platform}-#{arch}" => "pgschema"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pgschema --version 2>&1").strip
  end
end
