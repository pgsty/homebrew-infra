# typed: strict
# frozen_string_literal: true

class Pgbot < Formula
  desc "PostgreSQL diagnostics with baseline comparisons and JSON output"
  homepage "https://github.com/pgrundev/pgbot"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.10.0/pgbot_0.10.0_darwin_arm64.tar.gz"
      sha256 "d5e6bdd6d15c24aedac28a05138ee98adc73f51c9a4de93f58df2daa684c8f49"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.10.0/pgbot_0.10.0_darwin_amd64.tar.gz"
      sha256 "411c74ec2cc739aa206a390c7ef3d77b8770df6b61530aff54242be9b6933438"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.10.0/pgbot_0.10.0_linux_arm64.tar.gz"
      sha256 "442d6e14883dae2d2066eddc74d5176e8a2eb9d22dc4b7f293be64f79db08cce"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.10.0/pgbot_0.10.0_linux_amd64.tar.gz"
      sha256 "102dd639639ab7a4c2a933bf612390e21b699962ee33d9c939128657e416ae2e"
    end
  end

  def install
    bin.install "pgbot"
    doc.install "README.md"
  end

  test do
    assert_match "pgbot version #{version}", shell_output("#{bin}/pgbot --version")
    assert_match "pg_stat_user_tables", shell_output("#{bin}/pgbot explain-finding low_hot_update_ratio")
  end
end
