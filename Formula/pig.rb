# typed: strict
# frozen_string_literal: true

class Pig < Formula
  desc "PostgreSQL extension package manager and administration CLI"
  homepage "https://pig.pgsty.com"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.10.4/pig-v1.10.4.darwin-arm64.tar.gz"
      sha256 "d0f876a518b82f021c83914c5909f1ac914cbe8c0aa0957cef37c83d69b79b0d"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.4/pig-v1.10.4.darwin-amd64.tar.gz"
      sha256 "9384759851af53f5cddc381007f78de9a226b43b914848291df86ec41096119e"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.10.4/pig-v1.10.4.linux-arm64.tar.gz"
      sha256 "756b7c94936a4c8cca1b0a15f3bcac8eee9669480b8d6af205e920b673a680ba"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.4/pig-v1.10.4.linux-amd64.tar.gz"
      sha256 "1caa6f4af13e1f40f5faa9752628efe1dd85190b344bf1597cb3c8d23e99fe0b"
    end
  end

  def install
    bin.install "pig"
  end

  test do
    assert_match "pig version #{version}", shell_output("#{bin}/pig version")
    assert_match "PostgreSQL", shell_output("#{bin}/pig --help")
  end
end
