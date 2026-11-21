# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.1.0/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "720b453c37e6a7b6f38823ad766619cd4d89db2c27a28d877b006e48c8be518a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.1.0/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "d25adebb26828932762b70428ab34fd1829281782dea39abcde74f8f912946c7"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.1.0/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "834b10a6427c6821da53c3152cb93625a87f0206ae6973887f8d4e666d4facd1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.1.0/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e41352f1ea17e8f8759c75d6483118cd42ef1d28a95704fec548add7d24f1ea4"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
