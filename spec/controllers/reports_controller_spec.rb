require 'rails_helper'

RSpec.describe ReportsController, :type => :controller do
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
        image_url: expected_report.image_url
      ).stringify_keys
    end
    let(:expected_datetime) do
      date = report_params.values_at('year', 'month', 'day')
      year, month, day = date.map { |s| s.to_i }
      DateTime.new(year, month, day)
    end
    it 'should save the created Report' do
      post :create, :params => { :report => report_params }
      
      expect(assigns(:report).notes).to eq expected_report.notes
      expect(assigns(:report).image_url).to eq expected_report.image_url
      expect(assigns(:report).coffee_made_at).to eq expected_datetime
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

  describe 'PATCH update' do
    it 'should update the components' do
      report = FactoryBot.create(:report)

      report_param = report.as_json
      expected_image_url = Faker::Placeholdit.image('500x500', 'jpg')
      report_param['image_url'] = expected_image_url
      patch :update, :params => { id: "#{report.id}", :report => report_param }
      
      expect(assigns(:report).notes).to eq report.notes
      expect(assigns(:report).coffee_made_at).to eq report.coffee_made_at
      expect(assigns(:report).image_url).to eq expected_image_url 
    end
  end

  describe 'PUT update' do
    it 'should update the components' do
      report = FactoryBot.create(:report)

      report_param = report.as_json
      expected_image_url = Faker::Placeholdit.image('500x500', 'jpg')
      report_param['image_url'] = expected_image_url
      put :update, :params => { id: "#{report.id}", :report => report_param }
      
      expect(assigns(:report).notes).to eq report.notes
      expect(assigns(:report).coffee_made_at).to eq report.coffee_made_at
      expect(assigns(:report).image_url).to eq expected_image_url 
    end
  end
end

