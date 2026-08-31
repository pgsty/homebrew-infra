# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.10/mtail_3.4.10_darwin_arm64.tar.gz"
      sha256 "65e71f44b36b1e9c98ee92de152089652ccfe6b016b0c79a6b0620e51d9d30a6"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.10/mtail_3.4.10_darwin_amd64.tar.gz"
      sha256 "dabb411fae7a344bd5379d496164974a0934585ae2f4b0fb213f70649ec727e1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.10/mtail_3.4.10_linux_arm64.tar.gz"
      sha256 "470d434ff46e8898857b20b9cab177a1c322d7db18dcba269d9f8db1b1747f12"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.10/mtail_3.4.10_linux_amd64.tar.gz"
      sha256 "353eae1d355075871a891cc8364dbc0f33910f23c5ecbe2b334e7eceb4ded1de"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
