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
      url "https://github.com/pgsty/pig/releases/download/v1.8.0/pig-v1.8.0.darwin-arm64.tar.gz"
      sha256 "e0ccf61c4d135dbc45359c207751092aeb6df788e826bb73eccc1a1ed8800998"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.8.0/pig-v1.8.0.darwin-amd64.tar.gz"
      sha256 "f023a5c9049dc532a057e932c73a8197683eaf4d97cb7a8f219492da1ad2a65f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.8.0/pig-v1.8.0.linux-arm64.tar.gz"
      sha256 "9d23875804f87e78039498245059fd6b765831f027aacfc511ad0ac42711fa7b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.8.0/pig-v1.8.0.linux-amd64.tar.gz"
      sha256 "a24a08c1b8d54adcdef5a99ed7b91caeedef1552a1440b1258eb4eb07fb20353"
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
