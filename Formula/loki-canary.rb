# typed: strict
# frozen_string_literal: true

class LokiCanary < Formula
  desc "Synthetic log writer and reader for validating Loki availability"
  homepage "https://grafana.com/docs/loki/latest/operations/loki-canary/"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/grafana/loki/releases/download/v3.6.18/loki-canary-darwin-arm64.zip"
      sha256 "b70d32271bf6452688942a320baa572578764e9a3c80363ba6989f711e41a54f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/grafana/loki/releases/download/v3.6.18/loki-canary-darwin-amd64.zip"
      sha256 "81e1bd066b047bd350976956fa1062ae91ce7bc367202ddbebd6c978c696c57a"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/grafana/loki/releases/download/v3.6.18/loki-canary-linux-arm64.zip"
      sha256 "d16ff6d5ab1b6eaea78c9d7620ab8dcf48cb9b2f7d16374f3f3918f7a08eebbc"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/grafana/loki/releases/download/v3.6.18/loki-canary-linux-amd64.zip"
      sha256 "dd2c45801a1e8f94fe15efc60beee82400b3aea0f81da4e86b57ba3f920475f3"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "loki-canary-#{platform}-#{arch}" => "loki-canary"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/loki-canary --version 2>&1")
  end
end
