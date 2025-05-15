# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, only: %i[reject publish archive]
  before_action :load_categories, only: %i[for_moderation]
  before_action :set_page_params, only: %i[for_moderation index]
  before_action :set_q_params, only: %i[index]
  before_action :load_categories, only: %i[index]

  def for_moderation
    @bulletins = Bulletin.where(state: :under_moderation).page(@page).per(20)
    @total_pages = @bulletins.total_pages
  end

  def index
    # @bulletins = Bulletin.all
    @q = Bulletin.ransack(@q_params)
    @bulletins = @q.result.page(@page).per(17)
    @total_pages = @bulletins.total_pages
  end

  def reject
    @bulletin.reject!
    flash.notice = t('admin.message.bulletin.rejected')
  rescue StandardError
    flash.alert = t('admin.message.bulletin.reject_failed')
  ensure
    redirect_back(fallback_location: admin_root_path)
  end

  def publish
    @bulletin.publish!
    flash.notice = t('admin.message.bulletin.published')
  rescue StandardError
    flash.alert = t('admin.message.bulletin.publish_failed')
  ensure
    redirect_back(fallback_location: admin_root_path)
  end

  def archive
    @bulletin.archive!
    flash.notice = t('admin.message.bulletin.archive')
  rescue StandardError
    flash.alert = t('admin.message.bulletin.archive_fail')
  ensure
    redirect_back(fallback_location: admin_root_path)
  end
end
