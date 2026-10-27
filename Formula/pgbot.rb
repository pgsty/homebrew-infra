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
      url "https://github.com/pgrundev/pgbot/releases/download/v0.9.0/pgbot_0.9.0_darwin_arm64.tar.gz"
      sha256 "04c5e2463388716067302968ece839d37dcff5aeae91bbf8997a50e824681a03"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.9.0/pgbot_0.9.0_darwin_amd64.tar.gz"
      sha256 "ba9bf9b7879e0287184f70fcb0898fe86c006e7c4fe2b1a0d76354ca49b1d17e"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.9.0/pgbot_0.9.0_linux_arm64.tar.gz"
      sha256 "143fb4cde17b0d6d27d3887a9c29967b684f7a5037602f69a46d160c3be64c22"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.9.0/pgbot_0.9.0_linux_amd64.tar.gz"
      sha256 "adf0f08fbdd212a8c6b1e0462f872916866968c25e6e35ba1b5bba22a39841bc"
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
