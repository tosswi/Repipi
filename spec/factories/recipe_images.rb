FactoryBot.define do
    factory :recipe_image do
        recipe_image{ Faker::Lorem.characters(number:1000) }
    end
end