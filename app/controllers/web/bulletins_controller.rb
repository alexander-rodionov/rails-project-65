# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :set_bulletin, only: %i[show edit update to_moderate archive]
  before_action :load_categories, only: %i[new index edit]
  before_action :set_q_params, only: :index
  before_action :set_page_params, only: :index

  def index
    @q = Bulletin.where(state: :published).ransack(@q_params)
    @bulletins = @q.result.page(@page).per(8)
    @total_pages = @bulletins.total_pages
  end

  def show; end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def update
    @bulletin.update!(bulletin_params)
    redirect_to profile_path, notice: t('admin.message.bulletin.updated')
  rescue
    redirect_to :edit_bulletin, alert: t('admin.message.bulletin.update_failed')
  end

  def to_moderate
    @bulletin.to_moderation!
    flash.notice = t('admin.message.bulletin.to_moderate')
  rescue Exception => e
    pp e
    flash.alert = t('admin.message.bulletin.to_moderate_fail')
  ensure
    redirect_back(fallback_location: root_path)
  end

  def archive
    @bulletin.archive!
    flash.notice = t('admin.message.bulletin.archive')
  rescue Exception
    flash.alert = t('admin.message.bulletin.archive_fail')
  ensure
    redirect_back(fallback_location: root_path)
  end

  def create
    @bulletin = Bulletin.create!(bulletin_params)
    redirect_to profile_path, notice: t('admin.message.bulletin.created')
  rescue
    render :new, alert: t('admin.message.bulletin.create_failed')
  end

  private

  def bulletin_params
    result = params[:bulletin].permit(%i[title description category_id image])
    result[:user] = current_user
    result.except(:category)
  end
end
