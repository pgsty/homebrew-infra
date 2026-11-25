# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.15.0/pgschema-1.15.0-darwin-arm64", using: :nounzip
      sha256 "00561da57be0f185b1ea67b2328db233a394ed172478998db7dfd65b8400c07f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.15.0/pgschema-1.15.0-darwin-amd64", using: :nounzip
      sha256 "1447fb5a11344cd2643d7a81ccbb7f0ca9a0ca1c2ff3b8c74bbb03a62117da06"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.15.0/pgschema-1.15.0-linux-arm64", using: :nounzip
      sha256 "b9372db102c048e65f56ffe3294b2a6d8fab197db58a963da2d6fa659085e599"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.15.0/pgschema-1.15.0-linux-amd64", using: :nounzip
      sha256 "51a5315cf8f27ab8bc3379aa29f0a8eed1aa73b8fa7e1f4fb1f1e303bc6481bb"
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
