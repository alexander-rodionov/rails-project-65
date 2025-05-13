# frozen_string_literal: true

class Web::BulletinController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit to_moderate archive]
  before_action :load_categories, only: %i[new index edit]
  before_action :set_q_params, only: :index
  before_action :set_page_params, only: :index

  def index
    @q = Bulletin.ransack(@q_params)
    @bulletins = @q.result.page(@page).per(10)
    @total_pages = @bulletins.total_pages
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
