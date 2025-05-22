# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  validates :title, length: {
    minimum: 2,
    maximum: 50
  }

  validates :description, length: {
    minimum: 5,
    maximum: 1000
  }

  has_one_attached :image
  validates :image, attached: true

  aasm column: 'state' do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderation do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title state]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category]
  end

  private

  def image_attached
    errors.add(:image, :blank) unless image.attached?
  end
end
