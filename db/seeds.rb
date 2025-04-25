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

[
  { name: 'User1', email: 'some1@mail.com', admin: true },
  { name: 'User2', email: 'some2@mail.com', admin: true }
].each { |r| User.create!(r) }


[
  { name: 'Category 1' },
  { name: 'Category 2' },
].each { |r| Category.create!(r) }

[
  { title: 'Message 1', description: "Message body 1", category: Category.first, state:'draft', user: User.first },
  { title: 'Message 2', description: "Message body 2", category: Category.first, state:'draft', user: User.first },
].each { |r| Bulletin.create!(r) }
