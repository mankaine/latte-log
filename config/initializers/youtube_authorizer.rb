require 'google/apis'
require 'google/apis/youtube_v3'
require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'fileutils'
if Rails.env.test? || Rails.env.development?
  require './config/environment_variables.rb'
end

class InvalidYoutubeAPICredentialsError < StandardError
end

module YoutubeAuthorizer
  APPLICATION_NAME = 'Latte Log'.freeze
  CLIENT_ID = Google::Auth::ClientId.new(
    ENV['GOOGLE_AUTH_CLIENT_ID'].freeze,
    ENV['GOOGLE_AUTH_CLIENT_SECRET'].freeze
  )
  REDIRECT_URI = 'https://latte-log.herokuapp.com/'
  SCOPE = Google::Apis::YoutubeV3::AUTH_YOUTUBE_FORCE_SSL
  TOKEN_STORE = Google::Auth::Stores::RedisTokenStore.new(redis: $redis)
  USER_ID = 'default'.freeze

  def self.get_credentials
    YoutubeAuthorizer.authorizer
    @credentials ||= @authorizer.get_credentials YoutubeAuthorizer::USER_ID
    if @credentials.nil?
      url = authorizer.get_authorization_url(base_url: REDIRECT_URI)
      puts "Open the following URL in the browser and enter the " +
           "resulting code after authorization"
      puts url
      code = gets
      YoutubeAuthorizer.get_and_store_credentials code
    end
    @credentials
  end

  def self.authorizer
    @authorizer ||= Google::Auth::UserAuthorizer.new(
      YoutubeAuthorizer::CLIENT_ID,
      YoutubeAuthorizer::SCOPE,
      YoutubeAuthorizer::TOKEN_STORE
    )
  end

  def self.get_and_store_credentials(code)
    @credentials ||= authorizer.get_and_store_credentials_from_code(
      user_id: YoutubeAuthorizer::USER_ID,
      code: code,
      base_url: YoutubeAuthorizer::REDIRECT_URI
    )
  end

  def self.authorization_url
    @auth_url ||= @authorizer.get_authorization_url(base_url: REDIRECT_URI)
  end
end

$youtube_service = Google::Apis::YoutubeV3::YouTubeService.new
$youtube_service.client_options.application_name = YoutubeAuthorizer::APPLICATION_NAME
$youtube_service.authorization = YoutubeAuthorizer.get_credentials

