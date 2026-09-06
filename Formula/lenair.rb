# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.2.0/lenair-darwin-arm64-v0.2.0-lenair.tar.gz"
  version "0.2.0"
  sha256 "85cbc7df18261d21427ba5e03a358a3935bdfa5afee8692bbeeab30530313ae4"
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
