FactoryBot.define do
  factory :image, class: OpenStruct do
    mounted_as { :picture }

    after(:build) do |image|
      image.file = FactoryBot.build(:file)
    end

    after(:create) do |image|
      image.file = FactoryBot.create(:file)
    end
  end
end
