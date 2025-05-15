# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

Bulletin.destroy_all
Category.destroy_all
User.destroy_all
ActiveStorage::Attachment.find_each(&:purge)

30.times do
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    admin: [true, false].sample
  )
end

5.times do
  Category.create!(
    name: Faker::Book.unique.genre
  )
end

100.times do
  b = Bulletin.create!(
    title: Faker::Book.unique.title,
    description: Faker::Lorem.paragraph,
    category: Category.all.sample,
    state: %w[draft published archived].sample,
    user: User.all.sample
  )

  file_name = "db/seed_images/#{1 + (5 * rand).floor}.jpg"
  image_file = File.open(file_name)
  b.image.attach(io: image_file, filename: file_name)
end

# [
#   { name: 'User1', email: 'some1@mail.com', admin: true },
#   { name: 'User2', email: 'some2@mail.com', admin: true }
# ].each { |r| User.create!(r) }

# [
#   { name: 'Category 1' },
#   { name: 'Category 2' },
# ].each { |r| Category.create!(r) }

# [
#   { title: 'Some Message 1', description: "Some body 1", category: Category.first, state: 'draft', user: User.first },
#   { title: 'Another Message 2', description: "Another body 2", category: Category.second, state: 'draft', user: User.first },
# ].each { |r| Bulletin.create!(r) }
