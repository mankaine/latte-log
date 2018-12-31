FactoryBot.define do
  factory :report_request, class: Hash do
    notes { Faker::Lorem.sentence 2 }
    image_url { Faker::Placeholdit.image }
    day { Faker::Number.between(1, 28).to_s }
    month { Faker::Number.between(1, 12).to_s  }
    year { Faker::Number.between(0, 5000).to_s }

    initialize_with { attributes }
  end
end

