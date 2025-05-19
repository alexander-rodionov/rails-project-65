# frozen_string_literal: true

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
  b = Bulletin.new(
    title: Faker::Book.unique.title,
    description: Faker::Lorem.paragraph,
    category: Category.all.sample,
    state: %w[draft published archived].sample,
    user: User.all.sample
  )
  file_name = "db/seed_images/#{1 + (5 * rand).floor}.jpg"
  image_file = File.open(file_name)
  b.image.attach(io: image_file, filename: file_name)
  b.save!
end
