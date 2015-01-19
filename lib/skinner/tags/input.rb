class Skinner::Tags::Input < Liquid::Tag

  def initialize(tag_name, field, token)
    super
    @arguments = field.split(",").map(&:strip)
  end

  def render(context)
    field = context.find_variable(variable_name)
    field_for(field.field_type).render(field, tag_options)
  end

  def variable_name
    @arguments.first
  end

  def tag_options
    @tag_options ||= Skinner.hash_from_array(@arguments.drop(1))
  end

  private

  def field_for(field_type)
    "Skinner::Fields::#{field_type.classify}".constantize.new(field_type)
  end

  Liquid::Template.register_tag("input", Skinner::Tags::Input)
end
