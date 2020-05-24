FactoryBot.define do
    factory :recipe_review do
        recipe_comment{ Faker::Lorem.characters(number:1000) }
    end
end