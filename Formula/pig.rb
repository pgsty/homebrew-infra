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
      url "https://github.com/pgsty/pig/releases/download/v1.10.2/pig-v1.10.2.darwin-arm64.tar.gz"
      sha256 "60df049a38e109bccb3089d74fa41e0d22606ce4df0e4fadae39530d546ca731"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.2/pig-v1.10.2.darwin-amd64.tar.gz"
      sha256 "a54be0a4ceadf1e047b74fdb187ff57e9f97b81907c8d66795e7787de88ad864"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.10.2/pig-v1.10.2.linux-arm64.tar.gz"
      sha256 "e1e84d5afcddc8e474d130de638bc400bb965f887bdc9face842f111fb94afeb"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.2/pig-v1.10.2.linux-amd64.tar.gz"
      sha256 "686c5d6cf682a5a5a1d70cc09a86fecc441b22456f79bb84f192c4730ac2bd8a"
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
