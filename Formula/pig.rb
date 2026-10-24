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
      url "https://github.com/pgsty/pig/releases/download/v1.10.1/pig-v1.10.1.darwin-arm64.tar.gz"
      sha256 "1177f3b616279100ce97d23eb4fa6bc2e8daf02dbd23780a8dd5025240082c5a"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.1/pig-v1.10.1.darwin-amd64.tar.gz"
      sha256 "31fea0e9513e551e2be8dc99a8fc0f77de4bdfe40e66dadc206e227254bb7942"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgsty/pig/releases/download/v1.10.1/pig-v1.10.1.linux-arm64.tar.gz"
      sha256 "6658242816263ea4f5e3abeb3454665098c7100c75c76a3e45386a15faf6f397"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgsty/pig/releases/download/v1.10.1/pig-v1.10.1.linux-amd64.tar.gz"
      sha256 "0e837098d45b080ddf9205681709dbc38318d2b65cbdaed711246fd5834c3b50"
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
