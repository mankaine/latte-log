require 'carrierwave/test/matchers'

RSpec.describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:report) { FactoryBot.build(:report) }
  let(:uploader) { ImageUploader.new(report) }
  let(:file_path) { 'spec/uploaders/test_image.jpg' }

  before do
    ImageUploader.enable_processing = true
    uploader.store! file_path
  end

  after do
    ImageUploader.enable_processing = true
    uploader.remove!
  end

  describe '#extension_whitelist' do
    it 'has the correct format' do
      expect(uploader.extension_whitelist).to eq(%w[jpg])
    end
  end

  describe '#public_id' do
    let(:uploader1) { ImageUploader.new(report) }
    let(:uploader2) { ImageUploader.new(report) }
    it 'should generate a non-changing ID for each file' do
      expect(uploader1.public_id).to eq(uploader1.public_id)
      expect(uploader2.public_id).to eq(uploader2.public_id)
    end

    it 'should generate different IDs for different files' do
      time1 = uploader1.public_id
      sleep 2.seconds # Required, as uploader ID is time based
      time2 = uploader2.public_id
      expect(time1).not_to eq(time2)
    end
  end
end
