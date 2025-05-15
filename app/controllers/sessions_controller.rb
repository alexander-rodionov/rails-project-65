# frozen_string_literal: true

class SessionsController < ApplicationController
  
  def new

  end
  def create
    auth = request.env['omniauth.auth']
    pp 'GITHUB OBJECT'
    pp '----------------------'
    pp auth
    pp '----------------------'
    #user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |u|
    #  u.email = auth.info.email
    #  u.name = auth.info.name
    #end
    user = User.take
    session[:user_id] = user.id
    redirect_to root_path, notice: auth.to_h
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end
end