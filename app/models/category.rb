# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name state]
  end
end
