# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.2.2/lenair-darwin-arm64-v0.2.2-lenair.tar.gz"
  version "0.2.2"
  sha256 "fa919133406e6e741baf0810f6341c848a1771cc8e3bd2fd900a01e28959d989"
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
