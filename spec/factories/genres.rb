FactoryBot.define do
    factory :genre do
        name{ Faker::Lorem.characters(number:15) }
    end
end