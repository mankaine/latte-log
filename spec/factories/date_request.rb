FactoryBot.define do
  factory :date_request, class: Hash do
    day { Faker::Number.between(1, 28).to_s }
    month { Faker::Number.between(1, 12).to_s  }
    year { Faker::Number.between(2015, 2020).to_s }
    
    initialize_with { attributes }
  end
end
