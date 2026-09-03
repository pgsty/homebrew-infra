# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.0/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "11b3139315f6da8fa283acda348110d3fbdd16e6098d62c00011297132567ee2"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.0/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "73eb017d8e857542474a1c64f646ee8fa573927ea54e1f7491358497c7d4a058"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.0/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "51597049ca980bc18cc4830c472bcb592c4cd1f9fe0b4ee8c5c6297818a60a84"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.0/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b74102688d0a758cb2ec411638c15ad574059bbf59d0ce62d522a5ae2387e5d"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
