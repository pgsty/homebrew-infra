# typed: strict
# frozen_string_literal: true

class Pgterm < Formula
  desc "PostgreSQL terminal workspace with diagnostics and SQL browsing"
  homepage "https://github.com/pgrundev/pgterm"
  license "Apache-2.0"

  depends_on "pgsty/infra/pgbot"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/pgrundev/pgterm/releases/download/v0.4.0/pgterm_0.4.0_darwin_arm64.tar.gz"
      sha256 "1f443107233fbbc9b8d0d696f35398bbb57f568549d414f131959bed70f0f579"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/pgrundev/pgterm/releases/download/v0.4.0/pgterm_0.4.0_darwin_amd64.tar.gz"
      sha256 "84172c2dfe4f3ebfcca333673ed40f7f67150467adae214125f61e3d85851230"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/pgrundev/pgterm/releases/download/v0.4.0/pgterm_0.4.0_linux_arm64.tar.gz"
      sha256 "678714a68b1b7bd80bfcb6c0fc3b517bb1d1170f128c219adf9e0ceb9cca9642"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/pgrundev/pgterm/releases/download/v0.4.0/pgterm_0.4.0_linux_amd64.tar.gz"
      sha256 "d96a72173b3c382e378438bfb7c0b87c2d3ea63d8ffc9fc0eb89f4a3ec5b62ed"
    end
  end

  def install
    bin.install "pgterm"
    doc.install "README.md"
  end

  test do
    assert_match "pgterm #{version}", shell_output("#{bin}/pgterm --version")
    assert_match "[settings]", shell_output("#{bin}/pgterm --default-config")
  end
end
