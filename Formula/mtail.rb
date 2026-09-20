# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.12/mtail_3.4.12_darwin_arm64.tar.gz"
      sha256 "c675af177209cb795f44beabd2bebcd78c758a70325002c91a116a689f2a6b14"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.12/mtail_3.4.12_darwin_amd64.tar.gz"
      sha256 "417e3abf89c7fa0e865d969bfff8f009bc9c275af66fd5c536b1a4552ac02250"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.12/mtail_3.4.12_linux_arm64.tar.gz"
      sha256 "acfde7e7cdbf8ecb1865d0cc9bc9dfe7dd657822377bfd5f81405c93b5fedaab"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.12/mtail_3.4.12_linux_amd64.tar.gz"
      sha256 "c5f1cca4891589ffa52a7c3a32e4802c1d4959e31626df953f3d388393720916"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
