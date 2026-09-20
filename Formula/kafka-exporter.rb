# typed: strict
# frozen_string_literal: true

class KafkaExporter < Formula
  desc "Prometheus exporter for Kafka metrics"
  homepage "https://github.com/danielqsj/kafka_exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.10.0/kafka_exporter-1.10.0.darwin-arm64.tar.gz"
      sha256 "1b700284a5ef09ce05c9959da87a20642e3f19409d348cddd82aa1c4c9a94900"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.10.0/kafka_exporter-1.10.0.darwin-amd64.tar.gz"
      sha256 "132edf15765bf74708cba29c853ce8d574ff4d8e2920a5165fcaeaa396d9e3e9"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.10.0/kafka_exporter-1.10.0.linux-arm64.tar.gz"
      sha256 "47c3c19eec67a511fde2afcc714f9cdc382642ffcd72a1ac4c9535d8d433fee1"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/danielqsj/kafka_exporter/releases/download/v1.10.0/kafka_exporter-1.10.0.linux-amd64.tar.gz"
      sha256 "246720dc4ecd8670801625423b7e44bbeb93115de07353cc6b4ea27e5bb7b87d"
    end
  end

  def install
    bin.install "kafka_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kafka_exporter --version 2>&1")
  end
end
