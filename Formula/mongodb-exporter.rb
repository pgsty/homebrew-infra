# typed: strict
# frozen_string_literal: true

class MongodbExporter < Formula
  desc "Prometheus exporter for MongoDB metrics"
  homepage "https://github.com/percona/mongodb_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.53.0/mongodb_exporter-0.53.0.darwin-arm64.tar.gz"
      sha256 "a626c36d6da92efe3a314c78df6721f58be58b5e626e5012248c34bbdfef722e"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.53.0/mongodb_exporter-0.53.0.darwin-amd64.tar.gz"
      sha256 "ad46107da1e06b06eb45e8b75d4f6cfc914522cf949d3db72c1f6f9f701bcf3f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.53.0/mongodb_exporter-0.53.0.linux-arm64.tar.gz"
      sha256 "a39159ce2602788670e58c43b2dcc8c402bbf364932ca69dfa3e9cb32bc9e24b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.53.0/mongodb_exporter-0.53.0.linux-amd64.tar.gz"
      sha256 "7477ce24c607b1b0e7fcb10b49a3e437cb80004dc42195041a0da805339232e3"
    end
  end

  def install
    bin.install "mongodb_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mongodb_exporter --version 2>&1")
  end
end
