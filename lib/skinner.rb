require "liquid"
require "nokogiri"

module Skinner
  extend self

  attr_accessor :link_format
  self.link_format = "/:id/:path"

  def hash_from_array(items)
    # TODO: find a way to do this without eval
    eval("{#{items.join(",")}}")
  end
end

class Liquid::Template
  def variables
    root.nodelist.select { |node| node.kind_of?(Liquid::Variable) }.map(&:raw).map(&:strip)
  end
end

require "skinner/version"
require "skinner/fields"
require "skinner/tags"
require "skinner/compiler"
