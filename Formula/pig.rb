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
      url "https://github.com/pgsty/pig/releases/download/v1.11.0/pig-v1.11.0.darwin-arm64.tar.gz"
      sha256 "474788f79563e99e7443e619bb7e594f598284c9a81f22d53f33bacf03c5da27"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.11.0/pig-v1.11.0.darwin-amd64.tar.gz"
      sha256 "d9c0b9b3bde4e5e53d64a0df177dcda48575eed0310178adaff11f6d33a76cd9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.11.0/pig-v1.11.0.linux-arm64.tar.gz"
      sha256 "4c2699618fb50d6bb5d2c0807e407442c69c9873a4d33dc3193bbab9c039bdcd"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.11.0/pig-v1.11.0.linux-amd64.tar.gz"
      sha256 "8f21efdd33d5a063eb7e12d2908912682af4dd94e336d82124ab9eb57808974c"
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
