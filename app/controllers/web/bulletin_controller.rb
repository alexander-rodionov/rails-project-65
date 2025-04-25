# frozen_string_literal: true

class Web::BulletinController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit to_moderate archive]
  before_action :load_categories, only: %i[new index edit]
  
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def update
    redirect_to profile_path
  end

  def to_moderate
    @bulletin.to_moderation
    flash.notice = 'ON MODERATION OK'
  rescue Exception => e
    pp e
    flash.alert = 'ON MODERATION FAIL'
  ensure
    redirect_back(fallback_location: root_path)
  end

  def archive
    @bulletin.archive
    flash.notice = 'ARCHIVE OK'
  rescue Exception => e
    pp e
    flash.alert = 'ARCHIVE FAIL'
  ensure
    redirect_back(fallback_location: root_path)
  end

  def create
    redirect_to profile_path
  end

end
