class Skinner::Tags::Link < Liquid::Tag

  def initialize(tag_name, page, tokens)
    super
    @arguments = page.split(",").map(&:strip)
  end

  def render(context)
    campaign = context.find_variable("campaign")
    query_string = context.find_variable("query_string")

    link = generate_link(campaign)
    link += "?#{query_string}" if query_string.present?
    tag_options[:href] = link

    attrs = tag_options.keys.map { |key| "#{key}=\"#{tag_options[key]}\"" }.join(" ")
    "<a #{attrs}>#{text}</a>"
  end

  def url
    @url ||= @arguments.first
  end

  def text
    @text ||= @arguments.drop(1).first
  end

  def tag_options
    @tag_options ||= Skinner.hash_from_array(@arguments.drop(2))
  end

  private

  def generate_link(campaign)
    tokens = [
      [/:id/, campaign.id],
      [/:path/, url]
    ]

    tokens.inject(Skinner.link_format) do |link, token|
      link.gsub(token.first, token.last)
    end
  end

  Liquid::Template.register_tag("link", Skinner::Tags::Link)
end
