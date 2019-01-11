require 'rails_helper'

RSpec.describe Video, type: :model do
  it 'should exist' do
    expect{Video.new}.to_not raise_error
  end

  it 'validates URL' do
    video = Video.new
    video.url = Faker::Lorem.sentence 1
    expect(video).not_to be_valid

    video = Video.new
    video.url = Faker::Internet.url
    expect(video).to be_valid
  end
end
