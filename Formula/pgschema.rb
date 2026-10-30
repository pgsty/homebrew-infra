# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.4/pgschema-1.13.4-darwin-arm64", using: :nounzip
      sha256 "8fc5a7953b0f4ebc1e95eccdc1659358e5aeda677fb794c8f6e16b4b53f03181"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.4/pgschema-1.13.4-darwin-amd64", using: :nounzip
      sha256 "9ecedda22947ef9dd1abfc6ebf8b458d582e2591edf651a8c58eaddc4f3cee06"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.4/pgschema-1.13.4-linux-arm64", using: :nounzip
      sha256 "5f7d81371111033ed1df54b894b3bd6eb2cb55c5c9fee20addf2aae67abb0c99"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.4/pgschema-1.13.4-linux-amd64", using: :nounzip
      sha256 "abce75a704ce411a8f9d1dcc786573d7e0e6dcc6b060a0e6b66a1550ed734bdb"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "pgschema-#{version}-#{platform}-#{arch}" => "pgschema"
    chmod 0755, bin/"pgschema"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pgschema --version 2>&1").strip
  end
end
