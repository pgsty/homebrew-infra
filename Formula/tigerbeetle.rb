# typed: strict
# frozen_string_literal: true

class Tigerbeetle < Formula
  desc "Financial transactions database"
  homepage "https://tigerbeetle.com"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/tigerbeetle/tigerbeetle/releases/download/0.17.9/tigerbeetle-universal-macos.zip"
      sha256 "4e085eaffc66c2ed82e7f94a8137c468256d2fb0b35152ccf903cc6676c22940"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/tigerbeetle/tigerbeetle/releases/download/0.17.9/tigerbeetle-universal-macos.zip"
      sha256 "4e085eaffc66c2ed82e7f94a8137c468256d2fb0b35152ccf903cc6676c22940"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/tigerbeetle/tigerbeetle/releases/download/0.17.9/tigerbeetle-aarch64-linux.zip"
      sha256 "413994920fe48b04f5aa86895b7a1d9d98d14803b29d4e91d2a6d0098fff4ef2"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/tigerbeetle/tigerbeetle/releases/download/0.17.9/tigerbeetle-x86_64-linux.zip"
      sha256 "af71f2c0057e3b409bf79940fa94894b738187b0d4f1e711097bca15df5d8cd4"
    end
  end

  # Homebrew's Mach-O parser does not recognize the upstream universal binary.
  skip_clean "bin/tigerbeetle"

  def install
    bin.install "tigerbeetle"
    chmod 0755, bin/"tigerbeetle"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tigerbeetle version")
    assert_match "process.release=", shell_output("#{bin}/tigerbeetle version --verbose")
  end
end
