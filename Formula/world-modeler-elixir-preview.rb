# frozen_string_literal: true

require "json"

class WorldModelerElixirPreview < Formula
  desc "Standalone Elixir preview of the World Modeler knowledge runtime"
  homepage "https://github.com/e0da/world-modeler"
  url "https://github.com/e0da/homebrew-beta/releases/download/world-modeler-elixir-preview-v2.0.0-pre.1/world-modeler-elixir-preview-darwin-arm64-v2.0.0-pre.1-world-modeler-elixir-preview.tar.gz"
  version "2.0.0-pre.1"
  sha256 "1d63e8d26a5eef6b2179031fe2d6a3cf9c57257339917ec6a9f031cd1bbbb23c"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/world-modeler" => "world-modeler-elixir-preview"
  end

  test do
    executable = bin/"world-modeler-elixir-preview"
    assert_equal version.to_s, shell_output("\"#{executable}\" --version").strip
    assert_match "call <capability-id>", shell_output("\"#{executable}\" --help")
    (testpath/"input.json").write "{}"
    (testpath/"context.json").write "{}"
    catalog = JSON.parse(shell_output("\"#{executable}\" call world-model.capability.catalog/v3 input.json context.json"))
    assert_equal "world-model-capability-catalog/v3", catalog.fetch("protocol")
    capabilities = catalog.fetch("capabilities").map { |entry| entry.fetch("id") }
    assert_includes capabilities, "world-model.model.select/v3"
    assert_includes capabilities, "world-model.object.create/v3"
    refute_predicate bin/"world-modeler", :exist?
    assert_predicate libexec/"libexec/world_modeler", :directory?
  end
end
