# typed: strict
# frozen_string_literal: true

class Pgschema < Formula
  desc "PostgreSQL declarative schema migration tool"
  homepage "https://www.pgschema.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.3/pgschema-1.13.3-darwin-arm64", using: :nounzip
      sha256 "e092e17ac93bf39adabde0a34b3517cb1803dc2b162752cb5af844e3cf42c6cb"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.3/pgschema-1.13.3-darwin-amd64", using: :nounzip
      sha256 "530de5c0e4aa1108f62125b13f1525d4d4d5ced49926c293d74ecf889340b7c9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.3/pgschema-1.13.3-linux-arm64", using: :nounzip
      sha256 "12a439ef4fb02fce845470f0dec57e4b031aee30c17103e52e94814f725d9a8f"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgplex/pgschema/releases/download/v1.13.3/pgschema-1.13.3-linux-amd64", using: :nounzip
      sha256 "83d5c6c08e19cdf09bbc00c44aa60ae7fd6047760e4107f17182a60915f2ae14"
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
