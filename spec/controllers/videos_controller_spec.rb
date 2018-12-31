require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  describe 'GET index' do
    it 'should contain all Videos' do
      video = FactoryBot.create(:video)
      put :index
      expect(assigns(:videos)).to eq [video]
    end
  end

  describe 'POST create' do
    let(:expected_video) { FactoryBot.build(:video) }
    let(:video_params) do
      FactoryBot.build(
        :video_request,
        url: expected_video.url,
        notes: expected_video.notes
      ).stringify_keys
    end
    it 'should save the Video' do
      post :create, :params => { :video => video_params }

      expect(assigns(:video).notes).to eq expected_video.notes
      expect(assigns(:video).url).to eq expected_video.url
    end
    it 'should retun to homepage with code 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET new' do
    it 'should create a new Video with nil attributes' do
      put :new
      expect(assigns(:video)).to be_a_new Video
    end
  end

  describe 'GET edit' do
    it 'should get the targeted Video' do
      video = FactoryBot.create(:video)
      put :edit, :params => { :id => video.id }
      expect(assigns(:video).id).to eq video.id
    end
  end

  describe 'GET show' do
    it 'should get the Video' do
      video = FactoryBot.create(:video)
      put :show, :params => { :id => video.id }
      expect(assigns(:video).id).to eq video.id
    end
  end

  describe 'PATCH update' do
    it 'should update the Video' do
      video = FactoryBot.create(:video)

      video_param = video.as_json
      expected_video_url = Faker::Internet.url
      video_param['url'] = expected_video_url
      patch :update, :params => { id: "#{video.id}", :video => video_param }

      expect(assigns(:video)).to have_attributes(
        url: video_param['url'],
        notes: video_param['notes']
      )
    end
  end

  describe 'PUT update' do
    it 'should update the Video' do
      video = FactoryBot.create(:video)

      video_param = video.as_json
      expected_video_url = Faker::Internet.url
      video_param['url'] = expected_video_url
      put :update, :params => { id: "#{video.id}", :video => video_param }

      expect(assigns(:video)).to have_attributes(
        url: video_param['url'],
        notes: video_param['notes']
      )
    end
  end

  describe 'DELETE destroy' do
    it 'should delete the Video' do
      video = FactoryBot.create(:video)
      delete :destroy, :params => { id: "#{video.id}" }
  
      expect(Video.count).to eq 0
    end
  end
end

