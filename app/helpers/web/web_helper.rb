# frozen_string_literal: true

module Web::WebHelper
  def categories_name(categories)
    categories.map { |c| [c.name, c.id] }
  end
end
