# frozen_string_literal: true

class CategoryPolicy < ApplicationPolicy
  ADMIN_ACTIONS = %i[show? create? new? update? edit? destroy?]
  ALLOWED_ACTIONS = %i[index?]
  OWNER_ACTIONS = %i[]

  ALLOWED_ACTIONS.each { |action| define_method(action) { true } }

  OWNER_ACTIONS.each { |action| define_method(action) { record.user == user } }

  ADMIN_ACTIONS.each { |action| define_method(action) { user&.admin? } }
end
