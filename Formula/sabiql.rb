# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.1/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "124ab147c2f6a10cc6a68431e961d7bf15d4650791a102ffd5437c858e4404ab"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.1/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "9e14e6b749a57f412b858771e6c761c1b2239f22909f1b260e955ca92d499dac"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.1/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "86faf38c2fe8c31fecab672f734b306759377d516c96d50700c41c8d702b2939"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.1/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c26b87d93e8bbfe8d1a25b8fd6506f869679395980dac1c188c9428d189cf6aa"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
