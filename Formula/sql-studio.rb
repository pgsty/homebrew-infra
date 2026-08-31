# typed: strict
# frozen_string_literal: true

class SqlStudio < Formula
  desc "Terminal SQL explorer for PostgreSQL, MySQL, SQLite, and more"
  homepage "https://github.com/frectonz/sql-studio"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.53/sql-studio-aarch64-apple-darwin.tar.xz"
      sha256 "927ca0e6fe71e85f648f55c3883beeb720848df7ea2387e2a82cff0c94ad348a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.53/sql-studio-x86_64-apple-darwin.tar.xz"
      sha256 "09de3bf71e6bfb9a7efd08007f85a590500fb169adb5d8bb7e355fab1732b0ca"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.53/sql-studio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "88de523a6c36dffbbcc68770bb55665626c904bdfb45b1fbc2a2943a47c03a7e"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/frectonz/sql-studio/releases/download/0.1.53/sql-studio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "55323af39b8acac55afb03a36c43922855e09d09feedde4f40415f1ee59311a3"
    end
  end

  def install
    bin.install "sql-studio"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sql-studio --version 2>&1")
  end
end
