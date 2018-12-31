require 'rails_helper'

RSpec.describe Report, type: :model do
  it 'should exist' do
    expect{Report.new}.to_not raise_error
  end
end
