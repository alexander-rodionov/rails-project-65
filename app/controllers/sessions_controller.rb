# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    auth = request.env['omniauth.auth']

    email = auth['info']['email']
    name = auth['info']['name'] || auth['info']['nickname']
    user = User.find_by(email: email)
    user = User.create!(name: name, email: email, admin: true) unless user
    session[:user_id] = user.id
    redirect_to root_path, notice: t('message.logged_in')
  rescue StandardError
    redirect_to root_path, alert: t('message.log_in_error')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('message.logged_out')
  end
end
