# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    auth =
    {'provider'=>'github',
    'uid'=>'9053113',
    'info'=>
    {'nickname'=>'alexander-rodionov',
    'email'=>'alexander.a.rodionov@gmail.com',
    'name'=>nil,
    'image'=>'https://avatars.githubusercontent.com/u/9053113?v=4',
    'urls'=>{'GitHub'=>'https://github.com/alexander-rodionov', 'Blog'=>''}},
    'credentials'=>
    {'token'=>'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', 'expires'=>false},
    'extra'=>
    {'raw_info'=>
    {'login'=>'alexander-rodionov',
    'id'=>9053113,
    'node_id'=>'MDQ6VXNlcjkwNTMxMTM=',
    'avatar_url'=>'https://avatars.githubusercontent.com/u/9053113?v=4',
    'gravatar_id'=>'',
    'url'=>'https://api.github.com/users/alexander-rodionov',
    'html_url'=>'https://github.com/alexander-rodionov',
    'followers_url'=>
    'https://api.github.com/users/alexander-rodionov/followers',
    'following_url'=>
    'https://api.github.com/users/alexander-rodionov/following{/other_user}',
    'gists_url'=>
    'https://api.github.com/users/alexander-rodionov/gists{/gist_id}',
    'starred_url'=>
    'https://api.github.com/users/alexander-rodionov/starred{/owner}{/repo}',
    'subscriptions_url'=>
    'https://api.github.com/users/alexander-rodionov/subscriptions',
    'organizations_url'=>
    'https://api.github.com/users/alexander-rodionov/orgs',
    'repos_url'=>'https://api.github.com/users/alexander-rodionov/repos',
    'events_url'=>
    'https://api.github.com/users/alexander-rodionov/events{/privacy}',
    'received_events_url'=>
    'https://api.github.com/users/alexander-rodionov/received_events',
    'type'=>'User',
    'user_view_type'=>'private',
    'site_admin'=>false,
    'name'=>nil,
    'company'=>nil,
    'blog'=>'',
    'location'=>nil,
    'email'=>nil,
    'hireable'=>nil,
    'bio'=>nil,
    'twitter_username'=>nil,
    'notification_email'=>nil,
    'public_repos'=>6,
    'public_gists'=>0,
    'followers'=>0,
    'following'=>0,
    'created_at'=>'2014-10-07T15:30:52Z',
    'updated_at'=>'2025-05-13T10:40:48Z',
    'private_gists'=>0,
    'total_private_repos'=>9,
    'owned_private_repos'=>9,
    'disk_usage'=>79645,
    'collaborators'=>0,
    'two_factor_authentication'=>false,
    'plan'=>
    {'name'=>'free',
    'space'=>976562499,
    'collaborators'=>0,
    'private_repos'=>10000}},
    'all_emails'=>
    [{'email'=>'alexander.a.rodionov@gmail.com',
    'primary'=>true,
    'verified'=>true,
    'visibility'=>'public'},
    {'email'=>'rodionovalex@yandex.ru',
    'primary'=>false,
    'verified'=>true,
    'visibility'=>nil}],
    'scope'=>'user'}}

    #auth = request.env['omniauth.auth']

    debugger
    email = auth['info']['email']
    name = auth['info']['name'] || auth['info']['nickname']
    user = User.find_by(email: email)
    user = User.create!(name: name, email: email, admin: true) unless user
    session[:user_id] = user.id
    redirect_to root_path, notice: 'OK'
  rescue StandardError => e
    redirect_to root_path, alert: 'ERROR'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out!'
  end
end
