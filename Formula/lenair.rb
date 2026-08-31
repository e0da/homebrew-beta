# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.1.0/lenair-darwin-arm64-v0.1.0-lenair.tar.gz"
  version  "0.1.0"
  sha256 "27b5b86c7172235a2a13952c7f13ef74b5d573357928233431a7fe9236612767"
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
