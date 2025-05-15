# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  ADMIN_ACTIONS = %i[publish? reject?].freeze
  OWNER_ACTIONS = %i[update? to_moderate? edit?].freeze
  OWNER_OR_ADMIN_ACTIONS = %i[archive?].freeze
  ALLOWED_ACTIONS = %i[index? show? create? new?].freeze

  ALLOWED_ACTIONS.each { |action| define_method(action) { true } }

  OWNER_ACTIONS.each { |action| define_method(action) { record.user == user } }

  OWNER_OR_ADMIN_ACTIONS.each { |action| define_method(action) { user.admin? || record.user == user } }

  ADMIN_ACTIONS.each { |action| define_method(action) { user.admin? } }
end
