require 'rails_helper'

RSpec.describe Report, type: :model do
  it 'should exist' do
    expect{Report.new}.to_not raise_error
  end

  describe '.group_by_year' do
    context 'given no reports' do
      it 'should return an empty Hash' do
        expect(Report.group_by_year).to eq(Hash.new)
      end
    end

    context 'given some reports' do
      let(:report1) { FactoryBot.create(:report, coffee_made_at: Time.new(2018, 2, 1)) }
      let(:report2) { FactoryBot.create(:report, coffee_made_at: Time.new(2018, 1, 1)) }
      let(:report3) { FactoryBot.create(:report, coffee_made_at: Time.new(2017, 1, 1)) }

      it 'should order by year and month, descending' do
        expected_ordering = { '2018' => [report1, report2], '2017' => [report3] }
        expect(Report.group_by_year).to eq(expected_ordering)
      end
    end
  end
end
