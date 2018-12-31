FactoryBot.define do
  factory :video_request, class: Hash do
    url { Faker::Internet.url }
    notes { Faker::Lorem.sentence 2 }       
 
    initialize_with { attributes }
  end
end

