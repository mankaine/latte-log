FactoryBot.define do
  factory :file, class: OpenStruct do
    mounted_as { :picture }
  end
end
