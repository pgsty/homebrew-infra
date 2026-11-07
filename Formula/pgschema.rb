# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.0/pgschema-1.14.0-darwin-arm64", using: :nounzip
      sha256 "04934af7407282d94618da17430cf1a1bcfe897948a568eebec1587d86374fc4"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.0/pgschema-1.14.0-darwin-amd64", using: :nounzip
      sha256 "0c117cbb68f77c6263ffe1a646ef36149111a60bce435afcc28fbaa3b1d4a27c"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.0/pgschema-1.14.0-linux-arm64", using: :nounzip
      sha256 "f94f7b0a46d996d93d2fb2a9fb0d089e5b144b776ea47a26770d78962b2a2f25"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.0/pgschema-1.14.0-linux-amd64", using: :nounzip
      sha256 "4454e4be42984368d2443265c7b433994d5fd86a5bb311192053126afd23979f"
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
