# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end
  def create
    auth = request.env['omniauth.auth']

    pp 'GITHUB OBJECT'
    pp '----------------------'
    pp auth
    pp '----------------------'

    email = auth&.into&.email
    name = auth&.info&.name

    User.create!(name: name, email: email, admin: true)

    # {"provider"=>"github",
    # app-1  |  "uid"=>"12345",
    # app-1  |  "info"=>{"email"=>"feycot@gmail.com", "name"=>"Nikolay"}}

    # user = User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |u|
    #  u.email = auth.info.email
    #  u.name = auth.info.name
    # end
    user = User.take
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
