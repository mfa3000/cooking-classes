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

puts "clears exiting data"
# Clear existing data (optional)
CookingClass.destroy_all
User.destroy_all

puts "creating fake data for users"
# Create fake users
users = []
2.times do
  users << User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "password"
  )
end
puts "fake users created"

puts "creating fake data for cooking classes"
# Create fake cooking classes
categories = ["Mexican", "Japanese", "Italian", "Thai", "Street Food", "Indian", "French", "Other"]

20.times do
  ethnic_category = Faker::Food.ethnic_category
  category = categories.include?(ethnic_category) ? ethnic_category : "Other"

  CookingClass.create(
    title: "#{ethnic_category} #{Faker::Food.dish} class",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: Faker::Commerce.price(range: 10..50),
    address: Faker::Address.full_address,
    date: Faker::Date.forward(days: 30),
    time: Faker::Time.forward(days: 30, period: :evening),
    capacity: Faker::Number.between(from: 5, to: 50),
    category: category,
    user: users.sample
  )
end
puts "fake cooking class created"
