require 'rails_helper'

RSpec.describe Video, type: :model do
  it 'should exist' do
    expect{Video.new}.to_not raise_error
  end
end
