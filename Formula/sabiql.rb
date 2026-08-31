# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v2.0.1/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "aae3cd87dfaf1c7488079eb70a2414966a6d12d24979ba6751f1a25b7e50d603"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v2.0.1/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "fa29378d66c8126a47c55b96a57dccc5f5d2b9361864a691239a1a7e443b06e9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v2.0.1/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9be5a8836961211b8438b24d037670684cae468cf59375a014f94248db04ccbc"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v2.0.1/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f88a643120d8d403cda97beb480c49383a484778e1434e96b82dfa9609a0cae0"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
