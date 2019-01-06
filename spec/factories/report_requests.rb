FactoryBot.define do
  factory :report_request, class: Hash do
    notes { Faker::Lorem.sentence 2 }

    initialize_with { attributes }
  end
end
