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
      url "https://github.com/pgsty/pig/releases/download/v1.9.0/pig-v1.9.0.darwin-arm64.tar.gz"
      sha256 "096284577d0493ddba871b51e820654b358c7f4eb9c11175674a1d21b2718824"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.9.0/pig-v1.9.0.darwin-amd64.tar.gz"
      sha256 "d7eb266e1b8ab60d20ac582c6b0e3741b7e8516ce1a56df447c0285b3e5dcab9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.9.0/pig-v1.9.0.linux-arm64.tar.gz"
      sha256 "ddfa80fbb34f6738dd68e0d04cd92355711330f6896cd650df7d71b012788def"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.9.0/pig-v1.9.0.linux-amd64.tar.gz"
      sha256 "a4b5ffca540bc4f924f86398bcad6cb7221ac7520b54b1d3fd32c9877d9cafd2"
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
