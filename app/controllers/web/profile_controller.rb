# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :load_categories, only: %i[show]

  def show
    @q = Bulletin.ransack(@q_params)
    @bulletins = @q.result.page(@page).per(15)
    @total_pages = @bulletins.total_pages
  end
end
