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
        @category.save!
        redirect_to admin_categories_path,
                    notice: t('admin.message.category.created')
      rescue StandardError => e
        register_rollbar_error(e)
        flash.now[:alert] = t('admin.message.category.create_failed')
        render :new, status: :unprocessable_entity
      end

      def update
        @category.update!(category_params)
        redirect_to admin_categories_path,
                    notice: t('admin.message.category.updated')
      rescue StandardError => e
        register_rollbar_error(e)
        flash.now[:alert] = t('admin.message.category.update_failed')
        render :edit, status: :unprocessable_entity
      end

      def destroy
        @category.destroy!
        flash[:notice] = t('admin.message.category.destroyed')
      rescue ActiveRecord::InvalidForeignKey
        flash[:alert] = t('admin.message.category.destroy_failed_foreign_key')
      rescue ActiveRecord::RecordNotDestroyed
        flash[:alert] = t('admin.message.category.destroy_failed', errors: @category.errors.full_messages.to_sentence)
      rescue StandardError => e
        register_rollbar_error(e)
        flash[:alert] = t('admin.message.category.destroy_failed')
      ensure
        redirect_to admin_categories_path
      end

      private

      def category_params
        params.expect(category: [:name])
      end
    end
  end
end
