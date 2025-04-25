# frozen_string_literal: true

class Admin::BulletinController < Admin::ApplicationController
  #before_action :set_bulletin, only: %i[reject publish]
  before_action :load_categories, only: %i[for_moderation]

  def for_moderation
    @bulletins = Bulletin.all
  end

  def index
    @bulletins = Bulletin.all
  end

  def reject
    redirect_back(fallback_location: admin_root_path)
  end

  def publish
    redirect_back(fallback_location: admin_root_path)
  end

end
