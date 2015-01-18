require "test_helper"

class Skinner::CompilerTest < ActiveSupport::TestCase

  test "#compile compiles liquid template from source file" do
    compiler = Skinner::Compiler.new
    compiler.stubs(source_for: template)

    result = compiler.compile("/some/path")
    assert_includes result.variables, "title"
    assert_includes result.variables, "heading"
  end

  test "#compile injects additional outputs when supplied" do
    compiler = Skinner::Compiler.new(additional_output: { head: %w(csrf_meta_tags) })
    compiler.stubs(source_for: template)

    result = compiler.compile("/some/path")
    assert_includes result.variables, "csrf_meta_tags"
  end

  test "#source_for reads file from views/path" do
    File.expects(:read).with("views/index.html")
    Skinner::Compiler.new.source_for("index.html")
  end

  private

  def template
    @template ||= <<-FILE
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <title>{{ title }}</title>
      </head>
      <body>
        <h1>{{ heading }}</h1>
      </body>
      </html>
    FILE
  end
end
