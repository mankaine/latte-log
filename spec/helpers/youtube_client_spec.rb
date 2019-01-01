RSpec.describe YoutubeClient do
  describe '.video_url_to_title' do
    context 'given valid url' do
    end
    context 'given invalid url' do
    end
  end

  describe '.dig_for_id' do
    context 'given valid url' do
      let(:id) { '-6NQZHyJYO8' }
      let(:url) { "https://www.youtube.com/watch?v=#{id}" }
      let(:subject) { described_class.dig_for_id url }
      it { is_expected.to eq [id] } 
    end

    context 'given invalid URL' do
      let(:url) { 'https://old.reddit.com' }
      let(:subject) { described_class.dig_for_id url }
      it { is_expected.to eq '' } 
    end

    context 'given a non url' do
      let(:val) { 'Bye Felica' }
      let(:subject) { described_class.dig_for_id val }
      it { is_expected.to eq '' } 
    end
  end
  
describe '.parse_responses' do
    context 'given no ids' do
      let(:response) { FactoryBot.build(:youtube_response_invalid) }
      let(:subject) { described_class.parse_response response }
      it { is_expected.to be_empty }
    end

    context 'given an id' do
      let(:subject) { described_class.parse_response response }
      let(:response) { FactoryBot.build(:youtube_response, items: videos) }
      let(:videos) { [FactoryBot.build(:youtube_video, snippet: snippet)] }
      let(:snippet) { FactoryBot.build( :youtube_video_snippet, title: expected_title) }
      let(:expected_title) { Faker::StarWars.quote }
      it { is_expected.to eq expected_title }
    end
  end
end

