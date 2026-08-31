# typed: strict
# frozen_string_literal: true

class PgTimetable < Formula
  desc "Advanced scheduling for PostgreSQL"
  homepage "https://www.pg-timetable.org"
  license "PostgreSQL"

  on_macos do
    on_arm do
      # update: darwin_arm64
      url "https://github.com/cybertec-postgresql/pg_timetable/releases/download/v7.1.0/pg_timetable_Darwin_arm64.tar.gz"
      sha256 "4f4dcb3ded20e0e7eb0de3820958447e230551db92ac5b27405924cf24f27f47"
    end
    on_intel do
      # update: darwin_amd64
      url "https://github.com/cybertec-postgresql/pg_timetable/releases/download/v7.1.0/pg_timetable_Darwin_x86_64.tar.gz"
      sha256 "3d8b4b03f9aae16cfeee3bdf1abcd3d83b036c2a5d384dd84d752e724c71d0c5"
    end
  end

  on_linux do
    on_arm do
      # update: linux_arm64
      url "https://github.com/cybertec-postgresql/pg_timetable/releases/download/v7.1.0/pg_timetable_Linux_arm64.tar.gz"
      sha256 "3710cffcf94b585bf4fee3dd50f864138d31eca251d49b5063a3c55e6adbd6f5"
    end
    on_intel do
      # update: linux_amd64
      url "https://github.com/cybertec-postgresql/pg_timetable/releases/download/v7.1.0/pg_timetable_Linux_x86_64.tar.gz"
      sha256 "5fb9151bae1bae83d33ed4499e7cdb674d47b0d278a5b1940e12fac7f1089a15"
    end
  end

  def install
    bin.install "pg_timetable"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pg_timetable --version 2>&1")
  end
end
