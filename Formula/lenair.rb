# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.1.1/lenair-darwin-arm64-v0.1.1-lenair.tar.gz"
  version "0.1.1"
  sha256 "4c92083b5ea7c7d7c5ecd94a775eebc5e0e0efaea7b01e6c8072f8317a362080"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/lenair"
    prefix.install "LICENSE"
  end

  test do
    assert_match "Usage: lenair", shell_output("#{bin}/lenair --help 2>&1")
  end
end
