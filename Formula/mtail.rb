# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.15/mtail_3.4.15_darwin_arm64.tar.gz"
      sha256 "397d4d2f091127508d74fc9bc5d59885cea9ba11b3ab6de635aad33d5858f7db"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.15/mtail_3.4.15_darwin_amd64.tar.gz"
      sha256 "4c1a6e0118ce1436bef07d9b3e492236b2f7d02697eeb65cd4ce79adf85ef21f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.15/mtail_3.4.15_linux_arm64.tar.gz"
      sha256 "e1161a4fcfd4dec38172019d81415721a09634b41d855d88e09a803343879881"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.15/mtail_3.4.15_linux_amd64.tar.gz"
      sha256 "b53a028feedbfc7c23ff17b6de7cc3afc9e2ad05929087894e086bbc56903e03"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
