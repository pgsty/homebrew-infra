# typed: strict
# frozen_string_literal: true

class KafkaExporter < Formula
  desc "Prometheus exporter for Kafka metrics"
  homepage "https://github.com/danielqsj/kafka_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.11.0/kafka_exporter-1.11.0.darwin-arm64.tar.gz"
      sha256 "4c6856cb610a84400df2d64516b50ad187568c1399214d1e3dbf8d3b619a66ac"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.11.0/kafka_exporter-1.11.0.darwin-amd64.tar.gz"
      sha256 "da70a5da19d08005b771ed09a6ce42cc854912b407606b8391b7b2146e17e9f1"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.11.0/kafka_exporter-1.11.0.linux-arm64.tar.gz"
      sha256 "4f5f0341cd5345d863b3017eb9bc143f653c43a7b37cd2bc5a6a4b028ef61c45"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.11.0/kafka_exporter-1.11.0.linux-amd64.tar.gz"
      sha256 "6a14dd10709d627d7be29a4b98fae8bb888761c7da54410e72bef8cdaf906e86"
    end
  end

  def install
    bin.install "kafka_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kafka_exporter --version 2>&1")
  end
end
