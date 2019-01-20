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
    let(:expected_notes) { Faker::Lorem.sentence 2 }
    let(:report_params) { FactoryBot.build(:report_request, notes: expected_notes).stringify_keys }
    let(:expected_day) { FactoryBot.build(:date_request).stringify_keys }
    let(:expected_time) { Time.new(expected_day['year'], expected_day['month'], expected_day['day']) }

    it 'should save the created Report' do
      post :create, :params => { :report => report_params, date: expected_day }
      
      expect(assigns(:report).notes).to eq expected_notes
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
end
