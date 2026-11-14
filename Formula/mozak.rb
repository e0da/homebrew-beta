# frozen_string_literal: true

# Homebrew package for the public Mozak release artifact.
class Mozak < Formula
  desc "Portable browser automation CLI with Docker-backed Chrome runtime"
  homepage "https://github.com/e0da/mozak"
  url "https://github.com/e0da/homebrew-beta/releases/download/v0.3.0/mozak-darwin-universal-v0.3.0-mozak.tar.gz"
  version "0.3.0"
  sha256 "2eec934e67c30164964b6fd6cb3f216f46ef387c6878a2136f3122bfdba1c09e"
  license :cannot_represent

  depends_on :macos

  def install
    libexec.install "libexec/mozak"
    pkgshare.install "assets"
    ag_grid_examples = pkgshare/"examples/ag-grid"
    ag_grid_examples.install \
      "share/mozak/examples/ag-grid/README.md",
      "share/mozak/examples/ag-grid/ag-grid-helper.js",
      "share/mozak/examples/ag-grid/fixture.html",
      "share/mozak/examples/ag-grid/demo.mozak.json"
    caller_owned_examples = pkgshare/"examples/caller-owned-composition"
    caller_owned_examples.install \
      "share/mozak/examples/caller-owned-composition/README.md",
      "share/mozak/examples/caller-owned-composition/page-script.js",
      "share/mozak/examples/caller-owned-composition/fixture.html",
      "share/mozak/examples/caller-owned-composition/demo.mozak.json",
      "share/mozak/examples/caller-owned-composition/worker.sh"
    (bin/"mozak").write_env_script libexec/"mozak", MOZAK_ASSETS_DIR: "#{pkgshare}/assets"
  end

  def caveats
    <<~EOS
      Mozak's managed Chrome runtime requires a working Docker CLI/runtime
      (Docker Desktop, OrbStack, or compatible docker compose). External-browser
      connections are caller-owned.

      For a fresh install, run:
        brew install e0da/beta/mozak

      To upgrade an existing installation, run:
        brew update
        brew upgrade e0da/beta/mozak

      Use `brew reinstall e0da/beta/mozak` only to intentionally reinstall
      the same formula version. After an upgrade, follow Mozak's managed Chrome
      update guidance for doctor, any prescribed restart, and page verification:
        https://github.com/e0da/mozak#upgrade-an-existing-installation
    EOS
  end

  test do
    assert_match "Usage: mozak", shell_output("#{bin}/mozak --help 2>&1")
    assert_match version.to_s, shell_output("#{bin}/mozak --version")

    archs = shell_output("lipo -archs #{libexec}/mozak")
    assert_match "arm64", archs
    assert_match "x86_64", archs

    assert_predicate pkgshare/"examples/ag-grid/fixture.html", :file?
    assert_predicate pkgshare/"examples/ag-grid/demo.mozak.json", :file?
    assert_predicate pkgshare/"examples/caller-owned-composition/page-script.js", :file?
    assert_predicate pkgshare/"examples/caller-owned-composition/worker.sh", :executable?
  end
end
