class Skinner::Compiler
  attr_reader :additional_output

  def initialize(additional_output: {})
    @additional_output = additional_output
  end

  def compile(template_path)
    source = Nokogiri::HTML(source_for(template_path))
    inject_additional_output(source)
    Liquid::Template.parse(source.to_html)
  end

  def source_for(template_path)
    File.read("views/#{template_path}")
  end

  private

  def inject_additional_output(html_document)
    additional_output.each do |selector, tokens|
      element = html_document.at(selector).last_element_child
      content = tokens.inject("") { |output, token| output + "{{ #{token} }}" }
      element.add_next_sibling(content)
    end
  end
end
