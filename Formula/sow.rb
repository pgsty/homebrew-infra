# typed: strict
# frozen_string_literal: true

class Sow < Formula
  desc "Local RPM and DEB software repository manager"
  homepage "https://github.com/pgsty/sow"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.7.1/sow_0.7.1_darwin_arm64.tar.gz"
      sha256 "8120188108b98c79beab3bc0c081f0a4bed15c45533ff43bf69f4be8672551a4"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.7.1/sow_0.7.1_darwin_amd64.tar.gz"
      sha256 "cc1d68911bc80c473d73ace6cbfd2ab586394ea0fb44709fb597d3b4fd44731c"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/sow/releases/download/v0.7.1/sow_0.7.1_linux_arm64.tar.gz"
      sha256 "2adbe314ec4033825bc54effd870bfdbdd366858a35145e7831d298f72438f5c"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/sow/releases/download/v0.7.1/sow_0.7.1_linux_amd64.tar.gz"
      sha256 "d1fd60997a86a2048bfe38a5b23a5bcab07e1d99b171133e64ff2b75e4694179"
    end
  end

  def install
    bin.install "sow"
    doc.install "README.md", "CHANGELOG.md", "THIRD_PARTY_NOTICES"
  end

  test do
    assert_match "sow #{version}", shell_output("#{bin}/sow version")
    assert_match "repository", shell_output("#{bin}/sow --help")
  end
end
