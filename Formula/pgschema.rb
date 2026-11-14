# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.1/pgschema-1.14.1-darwin-arm64", using: :nounzip
      sha256 "cf06ef72af0a318882b7418acc2f8862bddbb22bb0bf90a3aff2eb3f106b3e54"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.1/pgschema-1.14.1-darwin-amd64", using: :nounzip
      sha256 "671ef5a88e6fc6d73d8a5cd25ac7700a614b330970c542e79ea35ca8e62c5b7e"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.1/pgschema-1.14.1-linux-arm64", using: :nounzip
      sha256 "6a1617a21ba786a60c763e764437498e58d22f779e5e1e88684c1af2ad066688"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.14.1/pgschema-1.14.1-linux-amd64", using: :nounzip
      sha256 "0f3915acdd15fcbe28e4aa14ad08a7e558a21669e8d1d5afa95ad590e59647f7"
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
