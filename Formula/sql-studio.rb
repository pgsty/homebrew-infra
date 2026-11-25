# typed: strict
# frozen_string_literal: true

class SqlStudio < Formula
  desc "Terminal SQL explorer for PostgreSQL, MySQL, SQLite, and more"
  homepage "https://github.com/frectonz/sql-studio"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.54/sql-studio-aarch64-apple-darwin.tar.xz"
      sha256 "0116c21a651074469e1e49e7ca44f41dc7ca162f6d6c241dcea2a00d027cfcf5"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.54/sql-studio-x86_64-apple-darwin.tar.xz"
      sha256 "a36e001ae99df5576d8ccdcbd09118e10ce11e046c17fdc2cb63155c7f09a6d7"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.54/sql-studio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1cd19ca4f852228cfed9eccb4e894e772e1ee0c1cd46b58972b0375d60387657"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.54/sql-studio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ceadd0a42d53f4537ca6fa68a4464b32b9db53c3ba54205db3bd5a85c543a2b6"
    end
  end

  def install
    bin.install "sql-studio"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sql-studio --version 2>&1")
  end
end
