FactoryBot.define do
    factory :message do
        content{ Faker::Lorem.characters(number:1000) }
    end
end