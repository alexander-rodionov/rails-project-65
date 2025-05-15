# frozen_string_literal: true

module Web
  class ProfilesController < Web::ApplicationController
    before_action :load_categories, only: %i[show]

    def show
      @q = Bulletin.where(user: current_user).ransack(@q_params)
      @bulletins = @q.result.page(@page).per(15)
      @total_pages = @bulletins.total_pages
    end
  end
end
