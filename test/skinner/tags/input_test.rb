require "test_helper"

class Skinner::Tags::InputTest < ActiveSupport::TestCase

  class Drop < Liquid::Drop
    def initialize(attrs)
      singleton = class << self; self; end
      attrs.each { |attr, value| singleton.send(:define_method, attr) { value } }
    end
  end

  # Simple fields, just <input type="field_type"... />
  [:text, :email, :number, :checkbox].each do |fixture|
    attrs = { name: "field", field_type: fixture.to_s, required: false }
    field = Drop.new(attrs)

    test "renders an input field for #{field.field_type} fields" do
      drop = Drop.new(attrs)
      element = input_for(drop, template)

      assert_equal drop.name, element["id"]
      assert_equal drop.name, element["name"]
      assert_equal drop.field_type, element["type"]
    end

    test "marks the #{field.field_type} fields as required when necessary" do
      drop = Drop.new(attrs.merge(required: true))
      element = input_for(drop, template)

      assert_equal "required", element["required"]
    end

    test "sends extra options for #{field.field_type} fields along to render" do
      @template = Liquid::Template.parse("{% input field, class: 'field__input' %}")
      drop = Drop.new(attrs)
      element = input_for(drop, template)

      assert_equal "field__input", element["class"]
    end
  end

  test "renders a textarea for multi_line_text fields" do
    drop = create_drop(field_type: "multi_line_text", name: "some_field")
    element = input_for(drop, template, selector: "textarea")

    assert_equal drop.name, element["id"]
    assert_equal drop.name, element["name"]
  end

  test "sends extra options to the texarea tag" do
    @template = Liquid::Template.parse("{% input field, rows: 7, class: 'field__input' %}")
    drop = create_drop(field_type: "multi_line_text", name: "some_field", required: true)

    element = input_for(drop, template, selector: "textarea")
    assert_equal "required", element["required"]
    assert_equal "field__input", element["class"]
    assert_equal "7", element["rows"]
  end

  private

  def create_drop(attrs)
    defaults = { required: false }
    Drop.new(defaults.merge(attrs))
  end

  def template
    @template ||= Liquid::Template.parse("{% input field %}")
  end

  def input_for(field, template, selector: "input")
    Nokogiri::HTML(template.render("field" => field)).at(selector)
  end
end
