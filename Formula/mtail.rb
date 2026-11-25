# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.22/mtail_3.4.22_darwin_arm64.tar.gz"
      sha256 "8017b7c14e7d2699be293f75f20ffe0a796128f3f068b91e3c889eb9e955afdf"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.22/mtail_3.4.22_darwin_amd64.tar.gz"
      sha256 "22c272346e0036876f5d14dc933024bbb0ee5d011e5bb931b4473d304464a99b"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.22/mtail_3.4.22_linux_arm64.tar.gz"
      sha256 "dfaa7b26f12130eb5c87d3cb52f99f3a317dff00d94259a07ac05ac2fa998fd5"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.22/mtail_3.4.22_linux_amd64.tar.gz"
      sha256 "dcf240080a28cec0fd01cd094480f172c52dbb555feb27a1cf5f4a505cab3d4a"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
