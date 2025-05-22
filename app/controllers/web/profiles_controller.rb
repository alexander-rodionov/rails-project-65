# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :load_categories, only: %i[show]

    def show
      @page = params[:page] || 0
      @q = Bulletin.where(user: current_user).ransack(params[:q]&.permit!)
      @bulletins = @q.result.page(@page).per(15)
      @total_pages = @bulletins.total_pages
    end

    private

    def load_categories
      @categories = Category.all
    end
  end
end
