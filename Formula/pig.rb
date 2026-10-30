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
      url "https://github.com/pgsty/pig/releases/download/v1.10.3/pig-v1.10.3.darwin-arm64.tar.gz"
      sha256 "0eb3f0447107734ae7decf3bc16caf99087e86119e83ce34987ebb376285fb14"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.3/pig-v1.10.3.darwin-amd64.tar.gz"
      sha256 "16203993bbba93dee16a38eac3eedbf67ed2cce3c7894cedbba613e95578004c"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.10.3/pig-v1.10.3.linux-arm64.tar.gz"
      sha256 "5f25ff6cf634f708d5f70bde39a07d83fe9c7d1ef7d944395eb294eb64554ecf"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.3/pig-v1.10.3.linux-amd64.tar.gz"
      sha256 "a3e61d0d71b9226ac89aa3b1e29baa8c92e5109ecaa2c7e26343f474e5832e04"
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
