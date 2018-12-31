FactoryBot.define do
  factory :report do
    notes { Faker::Lorem.sentence 4 }
    image_url { Faker::Internet.url }
    coffee_made_at { Faker::Time.between(10.days.ago, Date.today, :all) }
  end
end
