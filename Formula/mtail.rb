# typed: strict
# frozen_string_literal: true

class Mtail < Formula
  desc "Extract monitoring data from application logs"
  homepage "https://github.com/jaqx0r/mtail"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.17/mtail_3.4.17_darwin_arm64.tar.gz"
      sha256 "dc2f1989f432dffa867434e121905d991910cda7e21072a7aae5ad3a271304b1"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.17/mtail_3.4.17_darwin_amd64.tar.gz"
      sha256 "2c501708968b7fa0633f4cb9621ce8670b39b225e08ab8f35218ec72e523ebda"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.17/mtail_3.4.17_linux_arm64.tar.gz"
      sha256 "892f34c87051c17bb05739d24f77326effccfa7b178c2ece72fd602cf895463d"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/jaqx0r/mtail/releases/download/v3.4.17/mtail_3.4.17_linux_amd64.tar.gz"
      sha256 "a10a9bb29231e774571b7ed4cbe092d1a78b10a71443866882b4a10c75989aff"
    end
  end

  def install
    bin.install "mtail"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mtail --version 2>&1")
  end
end
