module Skinner
  module Fields
    class Base

      attr_reader :type

      def initialize(type)
        @type = type
      end

      def default_options_for(field)
        {
          type: type,
          required: field.required ? "required" : nil,
          id: field.name,
          name: field.name
        }.delete_if { |_, value| value.nil? }
      end
    end

    class Input < Base
      def render(field, options = {})
        html_options = default_options_for(field).merge(options)
        attrs = html_options.keys.map { |key| "#{key}=\"#{html_options[key]}\"" }.join(" ")
        "<input #{attrs}>"
      end
    end

    class Text < Input; end
    class Email < Input; end
    class Number < Input; end
    class Checkbox < Input; end

    class MultiLineText < Base
      def render(field, options = {})
        html_options = default_options_for(field).merge(options).except(:type)
        attrs = html_options.keys.map { |key| "#{key}=\"#{html_options[key]}\"" }.join(" ")
        "<textarea #{attrs}></textarea>"
      end
    end
  end
end
