# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.12.5/pgschema-1.12.5-darwin-arm64", using: :nounzip
      sha256 "45f72aad6d54d4c21815e19844c566690cf1150cb61358fd9a1839c0060bf9ea"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.12.5/pgschema-1.12.5-darwin-amd64", using: :nounzip
      sha256 "2ee3f1ae1041c159a5cf21226858144b9231c3da7e799a78eeec39c0ed38c2a8"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.12.5/pgschema-1.12.5-linux-arm64", using: :nounzip
      sha256 "a347cda5ce428109cd949ff2fcaccda380296016338722efa4488cd8e2f681ec"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.12.5/pgschema-1.12.5-linux-amd64", using: :nounzip
      sha256 "bcef715edb71321c6a27886fcc74a423f923c62d731852668314efcce1402698"
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
