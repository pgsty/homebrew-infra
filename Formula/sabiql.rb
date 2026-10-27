# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.2/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "3c9ff0e8770fd9257c70643a2606a85581fdce29074376ecb4921c8d7595682f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.2/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "8ceb2937aea53faaf7e7b4e6a696c1d5383c149c4dc66dfa2beeefdbac85eae8"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.2/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a73a1a7f336462f633bea357b7ac237bbbeb52552429b7b6eb86e1165bf8ad29"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.2/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1a471cbd634f61f4070b2f7b853cac946bd34da04dd30116ce925ddf84ad2211"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
