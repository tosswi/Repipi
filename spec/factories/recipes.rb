FactoryBot.define do
    factory :recipe do
        name { Faker::Lorem.characters(number:30) }
        content{ Faker::Lorem.characters(number:2000) }
    end
end