# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user_info = request.env['omniauth.auth']
    debugger
    raise user_info # Your own session management should be placed here.
    #redirect_to root_path, notice: t('message.logged_out')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('message.logged_out')
  end
end
