# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.1.0-rc1/lenair-darwin-arm64-v0.1.0-rc1-lenair.tar.gz"
  version "0.1.0-rc1"
  sha256 "82df38846a65406b003b534d9dd8d5967d464370cb8327848bbbae05f2f431ab"
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
