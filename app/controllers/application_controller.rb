# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include RouteSynonymsHelper
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :handle_pundit_exception
  rescue_from StandardError, with: :handle_error if Rails.env.production?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception',
                  request: request,
                  user: current_user,
                  params: params.to_unsafe_h)
  end

  def handle_pundit_exception(exception)
    register_rollbar_error(exception)
    redirect_back(fallback_location: root_path, alert: t('errors.messages.not_authorized'))
  end

  def handle_error(exception)
    register_rollbar_error(exception)
    redirect_back(fallback_location: root_path)
  end
end
