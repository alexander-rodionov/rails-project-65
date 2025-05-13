# frozen_string_literal: true

class Admin::BulletinController < Admin::ApplicationController
  # before_action :set_bulletin, only: %i[reject publish]
  before_action :load_categories, only: %i[for_moderation]
  before_action :set_page_params, only: %i[for_moderation index]
  before_action :set_q_params, only: %i[index]
  before_action :load_categories, only: %i[index]

  def for_moderation
    @bulletins = Bulletin.page(@page).per(20)
    @total_pages = @bulletins.total_pages
  end

  def index
    # @bulletins = Bulletin.all
    @q = Bulletin.ransack(@q_params)
    @bulletins = @q.result.page(@page).per(17)
    @total_pages = @bulletins.total_pages
  end

  def reject
    redirect_back(fallback_location: admin_root_path)
  end

  def publish
    redirect_back(fallback_location: admin_root_path)
  end
end
