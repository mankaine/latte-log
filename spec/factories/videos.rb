FactoryBot.define do
  factory :video do
    url { Faker::Internet.url }
    notes { Faker::Lorem.sentence 2 }
  end
end

