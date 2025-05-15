# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.email = auth['info']['email']
      u.name = auth['info']['name']
      # Add any additional user attributes you want to save
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: 'Logged in successfully!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('message.logged_out')
  end

  def failure
  end
end
