# frozen_string_literal: true

module Web
  module Admin
    class CategoriesController < Web::Admin::ApplicationController
      before_action :set_category, only: %i[destroy edit update]

      def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def edit; end

      def create
        @category = Category.new(category_params)
        if @category.save
          redirect_to admin_categories_path,
                      notice: t('admin.message.category.created')
        else
          flash.now[:alert] = t('admin.message.category.create_failed')
          render :new, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          redirect_to admin_categories_path,
                      notice: t('admin.message.category.updated')
        else
          flash.now[:alert] = t('admin.message.category.update_failed')
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy!
        flash[:notice] = t('admin.message.category.destroyed')
      rescue ActiveRecord::InvalidForeignKey
        flash[:alert] = t('admin.message.category.destroy_failed_foreign_key')
      rescue ActiveRecord::RecordNotDestroyed
        flash[:alert] = t('admin.message.category.destroy_failed', errors: @category.errors.full_messages.to_sentence)
      ensure
        redirect_to admin_categories_path
      end

      private

      def category_params
        params.expect(category: [:name])
      end

      def set_category
        @category = Category.find(params[:id])
        authorize @category
      end
    end
  end
end
