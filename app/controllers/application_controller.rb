# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def load_categories
    @categories = Category.all
  end

  def set_bulletin
    item_id = params[:bulletin_id] || param_id
    @bulletin = Bulletin.find(item_id)
  end

  def param_id
    params[:id]
  end
  
  def set_category
    @category = Category.find(param_id)
  end
end
