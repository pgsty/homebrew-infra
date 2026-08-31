# typed: strict
# frozen_string_literal: true

class NginxExporter < Formula
  desc "Prometheus exporter for NGINX and NGINX Plus"
  homepage "https://github.com/nginx/nginx-prometheus-exporter"
  license "Apache-2.0"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/nginx/nginx-prometheus-exporter/releases/download/v1.5.3/nginx-prometheus-exporter_1.5.3_darwin_arm64.tar.gz"
      sha256 "781106d36a7875f09454b7818b728760a5f122cb15d7dcda26139a546dfc6a3c"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/nginx/nginx-prometheus-exporter/releases/download/v1.5.3/nginx-prometheus-exporter_1.5.3_darwin_amd64.tar.gz"
      sha256 "e84d2f7efcad135c137313751ce1fb3b3a6790b0cf7640dbf252b98aa9ef5321"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/nginx/nginx-prometheus-exporter/releases/download/v1.5.3/nginx-prometheus-exporter_1.5.3_linux_arm64.tar.gz"
      sha256 "a0b1a5f5bba09483bd2e04c759c1a75fffe46ca72c0314ee2bb925d1742ff23b"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/nginx/nginx-prometheus-exporter/releases/download/v1.5.3/nginx-prometheus-exporter_1.5.3_linux_amd64.tar.gz"
      sha256 "3a0dd1ea6db57cd360544d0aed38df4adabcfeb31e931dc481d535c66f92641d"
    end
  end

  def install
    bin.install "nginx-prometheus-exporter" => "nginx_exporter"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nginx_exporter --version 2>&1")
  end
end
