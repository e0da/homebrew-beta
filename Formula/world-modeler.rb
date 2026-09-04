# frozen_string_literal: true

# Homebrew package for the public World Modeler native release.
class WorldModeler < Formula
  desc "Portable capability-based runtime for JSON and JSONL world models"
  homepage "https://github.com/e0da/world-modeler"
  url "https://github.com/e0da/homebrew-beta/releases/download/world-modeler-v1.1.2/world-modeler-darwin-arm64-v1.1.2-world-modeler.tar.gz"
  version "1.1.2"
  sha256 "c73cf847425487b5e8537cd5f666168b438ed9462955301ba2d46aaa968c1d04"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/world-modeler"
    pkgshare.install Dir["share/world-modeler/*"]
    prefix.install "LICENSE"
  end

  test do
    bootstrap = pkgshare/"world-model.bootstrap.json"
    assert_equal version.to_s, shell_output("#{bin}/world-modeler --version").strip
    assert_match "Usage:", shell_output("#{bin}/world-modeler --help")
    assert_match '"valid": true', shell_output("#{bin}/world-modeler validate #{bootstrap}")
    assert_match "world-model.inspect/v1", shell_output("#{bin}/world-modeler capabilities #{bootstrap}")
  end
end
