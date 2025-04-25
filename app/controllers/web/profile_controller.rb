# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :load_categories, only: %i[show]

  def show
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result
  end
end
