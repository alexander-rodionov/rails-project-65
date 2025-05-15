# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end
  def create
    auth = request.env['omniauth.auth']

    pp 'GITHUB OBJECT'
    pp '----------------------'
    pp auth
    pp '----------------------'

    email = auth&.info&.email
    name = auth&.info&.name
    user =  User.create!(name: name, email: email, admin: true)
    session[:user_id] = user.id
    redirect_to root_path, notice: auth.to_h
  rescue Exception => e
    redirect_back alert: e.to_s
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end
end
