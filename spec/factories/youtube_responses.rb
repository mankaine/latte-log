require 'ostruct'

FactoryBot.define do
  factory :youtube_response, class: OpenStruct do
    after(:build) do |response|
      response.items ||= FactoryBot.build_list(:youtube_video, 1)
    end
     
    after(:create) do |response|
      response.items ||= FactoryBot.create_list(:youtube_video, 1)
    end
  end

  factory :youtube_video, class: OpenStruct do
    after(:build) do |response|
      response.snippet ||= FactoryBot.build(:youtube_video_snippet)
    end
     
    after(:create) do |response|
      response.snippet ||= FactoryBot.create(:youtube_video_snippet)
    end
  end

  factory :youtube_video_snippet, class: OpenStruct do
    title { Faker::StarWars.quote }
  end

  factory :youtube_response_invalid, class: OpenStruct do
    # YouTube's API returns no items given an invalid URL 
    after(:build) do |response|
      response.items = []
    end
     
    after(:create) do |response|
      response.items = []
    end
  end
end

