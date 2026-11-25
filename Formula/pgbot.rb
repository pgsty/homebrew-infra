# typed: strict
# frozen_string_literal: true

class Pgbot < Formula
  desc "PostgreSQL diagnostics with baseline comparisons and JSON output"
  homepage "https://github.com/pgrundev/pgbot"
  license "Apache-2.0"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.11.1/pgbot_0.11.1_darwin_arm64.tar.gz"
      sha256 "6bfd03ad300d59a31b6dfa6083448bb6481f7a564dde97845b8f642355a9fb7c"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.11.1/pgbot_0.11.1_darwin_amd64.tar.gz"
      sha256 "b7feadb097b708a49b2ead68e42b9cf915b90e31a8b183daf0a0709f47c8ad60"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.11.1/pgbot_0.11.1_linux_arm64.tar.gz"
      sha256 "ee12d92453c3b6694c906bf8d249f97bb29404eb64a42bb5e9469c7b7dd32b1b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgrundev/pgbot/releases/download/v0.11.1/pgbot_0.11.1_linux_amd64.tar.gz"
      sha256 "8385d329ca8d154104360816970d6d40da1f1730a0cb62bf618a34cdd4cc56a5"
    end
  end

  def install
    bin.install "pgbot"
    doc.install "README.md"
  end

  test do
    assert_match "pgbot version #{version}", shell_output("#{bin}/pgbot --version")
    assert_match "pg_stat_user_tables", shell_output("#{bin}/pgbot explain-finding low_hot_update_ratio")
  end
end
