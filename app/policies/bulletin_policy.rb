# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  ADMIN_ACTIONS = %i[publish? reject?]
  OWNER_ACTIONS = %i[update? to_moderate? edit?]
  OWNER_OR_ADMIN_ACTIONS = %i[archive?]
  ALLOWED_ACTIONS = %i[index? show? create? new?]

  ALLOWED_ACTIONS.each { |action| define_method(action) { true } }

  OWNER_ACTIONS.each { |action| define_method(action) { record.user.email == user.email } }
  
  OWNER_OR_ADMIN_ACTIONS.each { |action| define_method(action) { user.admin? || record.user == user } }

  ADMIN_ACTIONS.each { |action| define_method(action) { user.admin? } }
end
