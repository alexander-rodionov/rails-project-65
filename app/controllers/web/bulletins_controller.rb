# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    PAGE_SIZE = 8 

    before_action :set_bulletin, only: %i[show edit update to_moderate archive]
    before_action :load_categories, only: %i[new index edit create]

    def index
      @q_params = params[:q]&.permit!
      @page = params[:page] || 0
      @q = Bulletin.where(state: :published).ransack(@q_params)
      @bulletins = @q.result.page(@page).per(PAGE_SIZE)
      @total_pages = @bulletins.total_pages
    end

    def show; end

    def new
      @bulletin = Bulletin.new
    end

    def edit
      render :edit
    end

    def create
      @bulletin = Bulletin.new(bulletin_params)
      if @bulletin.save
        redirect_to profile_path, notice: t('admin.message.bulletin.created')
      else
        session[:bulletin_image] = bulletin_params[:image] if bulletin_params[:image]
        flash.now[:alert] = t('admin.message.bulletin.create_failed')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('admin.message.bulletin.updated')
      else
        redirect_to :edit_bulletin, alert: t('admin.message.bulletin.update_failed')
      end
    end

    def to_moderate
      if @bulletin.to_moderation && @bulletin.save
        flash.notice = t('admin.message.bulletin.to_moderate')
      else
        flash.alert = t('admin.message.bulletin.to_moderate_fail')
      end
      redirect_back(fallback_location: root_path)
    end

    def archive
      if @bulletin.archive && @bulletin.save
        flash.notice = t('admin.message.bulletin.archive')
      else
        flash.alert = t('admin.message.bulletin.archive_fail')
      end
      redirect_back(fallback_location: root_path)
    end

    private

    def bulletin_params
      result = params[:bulletin].permit(%i[title description category_id image])
      result[:user] = current_user
      result.except(:category)
    end

    def load_categories
      @categories = Category.all
    end

    def set_bulletin
      item_id = params[:bulletin_id] || params[:id]
      @bulletin = Bulletin.find(item_id)
      authorize @bulletin
    end
  end
end
