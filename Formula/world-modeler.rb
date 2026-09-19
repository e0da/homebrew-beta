# frozen_string_literal: true

require "json"

class WorldModeler < Formula
  desc "Native knowledge runtime for JSON and JSONL world models"
  homepage "https://github.com/e0da/world-modeler"
  url "https://github.com/e0da/homebrew-beta/releases/download/world-modeler-elixir-preview-v2.0.0-pre.4/world-modeler-elixir-preview-darwin-arm64-v2.0.0-pre.4-world-modeler-elixir-preview.tar.gz"
  version "2.0.0-pre.4"
  sha256 "7dcddf5ffc8ea3aedb36da8a3d72289eca3910a3399c87f3881c6762121bd39c"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/world-modeler" => "world-modeler"
  end

  test do
    executable = bin/"world-modeler"
    assert_equal version.to_s, shell_output("\"#{executable}\" --version").strip
    assert_match "call <capability-id>", shell_output("\"#{executable}\" --help")
    (testpath/"input.json").write "{}"
    (testpath/"context.json").write "{}"
    catalog = JSON.parse(shell_output("\"#{executable}\" call world-model.capability.catalog/v3 input.json context.json"))
    assert_equal "world-model-capability-catalog/v3", catalog.fetch("protocol")
    capabilities = catalog.fetch("capabilities").map { |entry| entry.fetch("id") }
    assert_includes capabilities, "world-model.model.select/v3"
    assert_includes capabilities, "world-model.object.create/v3"
    refute_predicate bin/"world-modeler-elixir-preview", :exist?
    assert_predicate libexec/"libexec/world_modeler", :directory?
    assert_match "model inspect", shell_output("\"#{executable}\" model --help")
    system "sh", libexec/"share/world-modeler/native-smoke", executable
  end
end
