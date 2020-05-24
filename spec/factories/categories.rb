FactoryBot.define do
    factory :category do
        name{ Faker::Lorem.characters(number:15) }
    end
end