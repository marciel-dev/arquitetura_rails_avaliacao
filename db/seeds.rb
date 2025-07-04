# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  first_name: "Admin Master",
  last_name: "MbaOnRails",
  email: "admin@mbaonrails.com",
  password: "123456",
  role: :admin
)

10.times do |i|
  User.create!(
    first_name: "Usuário #{i + 1}",
    last_name: "MbaOnRails",
    email: "user#{i + 1}@mbaonrails.com",
    password: "123456",
    role: :client
  )
end

100.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 10..500)
  )
end