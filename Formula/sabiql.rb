# typed: strict
# frozen_string_literal: true

class Sabiql < Formula
  desc "Modern terminal SQL client for PostgreSQL"
  homepage "https://github.com/riii111/sabiql"
  license "MIT"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.3/sabiql-aarch64-apple-darwin.tar.gz"
      sha256 "aca05fee709eef39da2490a858851299065e2bee10d7fff6459e2012c4167106"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.3/sabiql-x86_64-apple-darwin.tar.gz"
      sha256 "7e21a573b79795bb41527a971edfcd05ebe7c64220ea51fe41427e4d0c0b2a48"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.3/sabiql-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "975a2a81cb76d7f1a4ecb35de94f7c96cc944c8fcaefa44cb1518f57de1fb407"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/riii111/sabiql/releases/download/v3.0.3/sabiql-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67a693b1587ada0ebf515b9f97b2728125ad0ddcec69f556476eb57842f19442"
    end
  end

  def install
    bin.install "sabiql"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sabiql --version 2>&1")
  end
end
