# typed: strict
# frozen_string_literal: true

class MongodbExporter < Formula
  desc "Prometheus exporter for MongoDB metrics"
  homepage "https://github.com/percona/mongodb_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.54.0/mongodb_exporter-0.54.0.darwin-arm64.tar.gz"
      sha256 "3e877cea1862ab7df078bb8122450d227ed724b9e6fd1c79d1014a78eb3cb66f"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.54.0/mongodb_exporter-0.54.0.darwin-amd64.tar.gz"
      sha256 "60f1fbb96b66b73e2f7806c456d027f7cb9e95c1922b4f7181256147fcc0c72f"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.54.0/mongodb_exporter-0.54.0.linux-arm64.tar.gz"
      sha256 "79cb0d5137cc439d9ad385fe23667273d4f9c5a960c33141ed99b85e28172552"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/percona/mongodb_exporter/releases/download/v0.54.0/mongodb_exporter-0.54.0.linux-amd64.tar.gz"
      sha256 "84e5c8145f4e78df2915f5aa8f3ccddbfd1b817d6a29db5a27525bb68b4095b4"
    end
  end

  def install
    bin.install "mongodb_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mongodb_exporter --version 2>&1")
  end
end
