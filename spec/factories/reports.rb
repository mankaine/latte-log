FactoryBot.define do
  factory :report do
    notes { Faker::Lorem.sentence 4 }
    coffee_made_at { Faker::Time.between(10.days.ago, Date.today, :all) }

    after(:build) do |report|
      report.picture = FactoryBot.build(:image)
    end

    after(:create) do |report|
      report.picture = FactoryBot.create(:image)
    end
  end
end
