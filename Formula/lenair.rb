# frozen_string_literal: true

# Homebrew package for the public lenair release artifact.
class Lenair < Formula
  desc "Agent-first Linear CLI"
  homepage "https://github.com/e0da/lenair"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.1.0-rc1/lenair-darwin-arm64-v0.1.0-rc1-lenair.tar.gz"
  version "0.1.0-rc1"
  sha256 "10879066c6a82d6d9e0c9ad38cbcd538fd275214ea0a1424966b0963fabd79ba"
  license "MIT"

  depends_on :macos

  def install
    bin.install "bin/lenair"
  end

  test do
    assert_match "Usage: lenair", shell_output("#{bin}/lenair --help 2>&1")
  end
end
