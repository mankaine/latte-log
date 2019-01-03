require 'google/api_client/client_secrets.rb'
require 'google/apis/youtube_v3'

class YoutubeClient
  APPLICATION_NAME = 'Latte Log'.freeze

  def initialize
    @service = service
  end

  def video_url_to_title(part, url)
    video_id = dig_for_id url
    params = { id: video_id }
    params = params.delete_if { |p, v| v == '' }
    response = @service.list_videos(part, params)
    parse_response response
  end

  def dig_for_id(url)
    query = URI.parse(url).query rescue ''
    if query.nil?
      return ''
    end
    
    query_params = CGI.parse(query)
    # Youtube video IDs map to the 'v' parameter in URLs
    unless query_params.key? 'v'
      return ''
    end

    query_params['v']
  end

  def parse_response(response)
    if response.items.count.zero?
      ''
    else
      response.items.first.snippet.title
    end
  end

  private

  def service 
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.client_options.application_name = YoutubeClient::APPLICATION_NAME
    service.authorization = secret.to_authorization
    service
  end

  def secret
    byebug
=begin    
    Google::APIClient::ClientSecrets.new(
      secret = Hash.new
      secret['web'] = Hash.new
      secret['web']['access_token'] = @user.google_token
      secret['web'][]
      {
        'web' => {
          'access_token' => @app_user.google_token,
          'refresh_token' => @app_user.google_refresh_token,
          'client_id' => ENV['GOOGLE_AUTH_CLIENT_ID'],
          'client_secret' => ENV['GOOGLE_AUTH_CLIENT_SECRET'],
        }
      }
    )
=end
  end
end
