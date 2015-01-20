require "liquid"
require "nokogiri"

module Skinner
  cattr_accessor :link_format
  self.link_format = "/:id/:path"

  def hash_from_array(items)
    # TODO: find a way to do this without eval
    # rubocop:disable Lint/Eval
    eval("{#{items.join(",")}}")
    # rubocop:enable Lint/Eval
  end
  module_function :hash_from_array
end

class Liquid::Template
  def variables
    root.nodelist.select { |node| node.is_a?(Liquid::Variable) }.map(&:raw).map(&:strip)
  end
end

require "skinner/version"
require "skinner/fields"
require "skinner/tags"
require "skinner/compiler"
