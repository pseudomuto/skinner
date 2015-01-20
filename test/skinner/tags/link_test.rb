require "test_helper"

class Skinner::Tags::LinkTest < ActiveSupport::TestCase

  test "renders a theme specific link" do
    template = Liquid::Template.parse("{% link enter, Enter %}")
    html = template.render("campaign" => campaign)
    link = Nokogiri::HTML(html).at("a")

    assert_equal "/#{campaign.id}/enter", link["href"]
    assert_equal "Enter", link.text
  end

  test "adds options to the anchor tag" do
    template = Liquid::Template.parse("{% link enter, Enter, class: 'link', title: 'My Link' %}")
    html = template.render("campaign" => campaign)
    link = Nokogiri::HTML(html).at("a")

    assert_equal "link", link["class"]
    assert_equal "My Link", link["title"]
  end

  test "appends the query string to the link when available" do
    template = Liquid::Template.parse("{% link enter, Enter with Query, class: 'link', title: 'My Link' %}")
    html = template.render("campaign" => campaign, "query_string" => "testing=12&b=0")
    link = Nokogiri::HTML(html).at("a")

    assert_equal "/#{campaign.id}/enter?testing=12&b=0", link["href"]
  end

  private

  class Drop < Liquid::Drop
    def initialize(attrs)
      singleton = class << self; self; end
      attrs.each { |attr, value| singleton.send(:define_method, attr) { value } }
    end
  end

  def campaign
    attrs = { "id" => "1" }
    Drop.new(attrs)
  end
end
