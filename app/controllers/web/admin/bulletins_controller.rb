# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      PAGE_SIZE = 17 

      before_action :set_bulletin, only: %i[reject publish archive]
      before_action :load_categories, only: %i[index]

      def index
        @q_params = params[:q]&.permit!
        @page = params[:page] || 0
        @q = Bulletin.ransack(@q_params)
        @bulletins = @q.result.page(@page).per(PAGE_SIZE)
        @total_pages = @bulletins.total_pages
      end

      def reject
        if @bulletin.reject && @bulletin.save
          flash.notice = t('admin.message.bulletin.rejected')
        else
          flash.alert = t('admin.message.bulletin.reject_failed')
        end
        redirect_back(fallback_location: admin_root_path)
      end

      def publish
        if @bulletin.publish && @bulletin.save
          flash.notice = t('admin.message.bulletin.published')
        else
          flash.alert = t('admin.message.bulletin.publish_failed')
        end
        redirect_back(fallback_location: admin_root_path)
      end

      def archive
        if @bulletin.archive && @bulletin.save
          flash.notice = t('admin.message.bulletin.archive')
        else
          flash.alert = t('admin.message.bulletin.archive_fail')
        end
        redirect_back(fallback_location: admin_root_path)
      end

      private

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
end
