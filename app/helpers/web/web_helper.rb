module Web::WebHelper
  def categories_name(categories)
    categories.map { |c| c.name }
  end
end