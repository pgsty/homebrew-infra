# typed: strict
# frozen_string_literal: true

class KafkaExporter < Formula
  desc "Prometheus exporter for Kafka metrics"
  homepage "https://github.com/danielqsj/kafka_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.9.0/kafka_exporter-1.9.0.darwin-arm64.tar.gz"
      sha256 "4028caf854908db11b9d1258329f2c30b9519e314bf761f98424eadbf34bfb6b"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.9.0/kafka_exporter-1.9.0.darwin-amd64.tar.gz"
      sha256 "5d25bed9effc1f8a6be320eaa09353c0e886567e3abc673ab0e6c11c17c8f9af"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.9.0/kafka_exporter-1.9.0.linux-arm64.tar.gz"
      sha256 "b6991fcb50d2dc87fde02e003dc8c1b742022ab3becf30e4bb9979b22c1d37d8"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.9.0/kafka_exporter-1.9.0.linux-amd64.tar.gz"
      sha256 "c722518ad71c53b3988ea26ae2bd387bb596ce7a98fc639d08bf639a537699a1"
    end
  end

  def install
    bin.install "kafka_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kafka_exporter --version 2>&1")
  end
end
