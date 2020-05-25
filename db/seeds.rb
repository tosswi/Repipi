# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env == "development"
User.create!(name: "相川愛", nickname: "AI",sex: "男性", email: "ai@gmail", phone_number: "1234567891",password => 'aaaaaa',:encrypted_password => 'aaaaaa')
end