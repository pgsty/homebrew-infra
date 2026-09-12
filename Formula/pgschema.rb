# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.0/pgschema-1.13.0-darwin-arm64", using: :nounzip
      sha256 "e4c57db61757de751db16541ec0aa7afcf24945d69950092193e0a92d96a7b51"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.0/pgschema-1.13.0-darwin-amd64", using: :nounzip
      sha256 "c2c3f711475d5e36a2ecb4fdc1d251bab74b1de3209e5118d59314217e691ac3"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.0/pgschema-1.13.0-linux-arm64", using: :nounzip
      sha256 "eb5dc9484c628b21f729d7740a2648e489de4ae0934b38a400e93a5c93cf46b2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.0/pgschema-1.13.0-linux-amd64", using: :nounzip
      sha256 "75785f3750bc441b1f27390c8432d495a555801d0a1d7e58b5de4160a099db5d"
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
