# typed: strict
# frozen_string_literal: true

class Alertmanager < Formula
  desc "Handle alerts sent by Prometheus servers"
  homepage "https://prometheus.io/docs/alerting/latest/alertmanager/"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.1/alertmanager-0.34.1.darwin-arm64.tar.gz"
      sha256 "a3941879f340ef12a4cc1a479c82bd8520611265ea8d1ee25c88bd5f944d8293"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.1/alertmanager-0.34.1.darwin-amd64.tar.gz"
      sha256 "9f3a3806c81a2ef3546fea9bae3dd39abcf2206edd112c9433133a9355875fce"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.1/alertmanager-0.34.1.linux-arm64.tar.gz"
      sha256 "d98d6cbaf52151c7e76e24355fec88b11cebcb9875d4cdd8b76ddce7a7e5535c"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/prometheus/alertmanager/releases/download/v0.34.1/alertmanager-0.34.1.linux-amd64.tar.gz"
      sha256 "265b9d1e55ef0d5306a436018af6d2b686c2ce051f03d968f7464ecb1372a7e8"
    end
  end

  def install
    bin.install "alertmanager", "amtool"
    etc.install "alertmanager.yml"
    doc.install "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/alertmanager --version 2>&1")
    assert_match version.to_s, shell_output("#{bin}/amtool --version 2>&1")
  end
end
