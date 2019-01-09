require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do

  after(:each) do
    Report.destroy_all
  end

  describe 'GET new' do
    it 'should initalize a Report' do
      get :new
      expect(assigns(:report)).to be_a_new(Report)
    end
  end

  describe 'GET index' do
    it 'should provide all Reports' do
      report = FactoryBot.create(:report)
      get :index
      expect(assigns(:reports)).to eq([report])
    end
  end

  describe 'POST create' do
    let(:expected_report) { FactoryBot.build(:report) }
    let(:report_params) do
      FactoryBot.build(
        :report_request,
        notes: expected_report.notes,
      ).stringify_keys
    end
    let(:expected_day) { FactoryBot.build(:date_request).stringify_keys }
    let(:expected_time) { Time.new(expected_day['year'], expected_day['month'], expected_day['day']) }
    it 'should save the created Report' do
      post :create, :params => { :report => report_params, date: expected_day }
      
      expect(assigns(:report).notes).to eq expected_report.notes
      expect(assigns(:report).coffee_made_at).to eq expected_time
    end

    it 'should return to homepage with code 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET edit' do
    it 'should retrieve the requested Report' do
      report = FactoryBot.create(:report)
      get :edit, :params => { :id => report.id }
      expect(assigns(:report)).to eq report
    end
  end

  describe 'DELETE destroy' do
    let(:report_params) { FactoryBot.build(:report_request).stringify_keys }
    let(:expected_day) { FactoryBot.build(:date_request).stringify_keys }

    it 'should destory the requested Report' do
      expect(Report.count).to eq(0)
      post :create, :params => { :report => report_params, date: expected_day }
      expect(Report.count).to eq(1)
      report = Report.first

      delete :destroy, :params => { :id => report.id, :report => report }

      expect(assigns(:report)).to be_nil
      expect(Report.count).to eq(0)
    end
  end

  describe '#update' do
    let(:report) { FactoryBot.create(:report, coffee_made_at: expected_time) }
    let(:report_param) { report.as_json }
    let(:date_made) { FactoryBot.build(:date_request).stringify_keys }
    let(:expected_time) { Time.new(date_made['year'], date_made['month'], date_made['day']) }

    it 'should update the components' do
      patch :update, :params => { id: "#{report.id}", report: report_param, date: date_made }
      
      expect(assigns(:report).notes).to eq report.notes
      expect(assigns(:report).coffee_made_at).to eq report.coffee_made_at
    end
  end

  describe '#group_by_year' do
    context 'given no reports' do
      it 'should return an empty Hash' do
        expect(subject.group_by_year).to eq(Hash.new)
      end
    end

    context 'given some reports' do
      let(:report_params1) { FactoryBot.build(:report_request).stringify_keys }
      let(:report_params2) { FactoryBot.build(:report_request).stringify_keys }
      let(:report_params3) { FactoryBot.build(:report_request).stringify_keys }
      let(:date1) { {'year' => 2018, 'month' => 1, 'day' => 1} }
      let(:date2) { {'year' => 2017, 'month' => 1, 'day' => 1} }
      let(:date3) { {'year' => 2018, 'month' => 2, 'day' => 1} }

      it 'should order by year and month, descending' do
        post :create, :params => { :report => report_params1, date: date1 }
        post :create, :params => { :report => report_params2, date: date2 }
        post :create, :params => { :report => report_params3, date: date3 }

        expected_ordering = { 
          '2018' => [
            Report.find_by(coffee_made_at: Time.new(2018, 2, 1)),
            Report.find_by(coffee_made_at: Time.new(2018, 1, 1))
          ],
          '2017' => [
            Report.find_by(coffee_made_at: Time.new(2017, 1, 1))
          ],
        }
        expect(subject.group_by_year).to eq(expected_ordering)
      end
    end
  end
end
