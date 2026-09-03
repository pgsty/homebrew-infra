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
      url "https://github.com/pgsty/pig/releases/download/v1.8.1/pig-v1.8.1.darwin-arm64.tar.gz"
      sha256 "0fb6c86cc18a29aeb74e9d12e717c104087c6ecf5a43250dfcc71cd7681fb868"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.8.1/pig-v1.8.1.darwin-amd64.tar.gz"
      sha256 "6c08b6a698191b8b6494a0f60880fb17cafa535bad12d5c544333e4625048455"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.8.1/pig-v1.8.1.linux-arm64.tar.gz"
      sha256 "b30924880f21126ece3afc77ca75794a0ceb77964cdfd8bc20da72d9d3273078"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.8.1/pig-v1.8.1.linux-amd64.tar.gz"
      sha256 "9219e87433ebd239e0773ae7417fdd08e97bb511312e6747542bf46b6b1bbf2b"
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
