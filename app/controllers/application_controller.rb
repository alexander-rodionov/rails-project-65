# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RouteSynonymsHelper
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :handle_pundit_exception

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def load_categories
    pp 'Load Categories'
    @categories = Category.all
  end

  def set_bulletin
    item_id = params[:bulletin_id] || param_id
    @bulletin = Bulletin.find(item_id)
    authorize @bulletin
  end

  def param_id
    params[:id]
  end

  def set_category
    @category = Category.find(param_id)
    authorize @category
  end

  def set_page_params
    @page = params[:page] || 0
  end

  def set_q_params
    @q_params = params[:q]&.permit(%i[title_cont category_id_eq]).to_h
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def handle_pundit_exception(_e)
    redirect_back(fallback_location: root_path, alert: t('errors.messages.not_authorized'))
  end
end
