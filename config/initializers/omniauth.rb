require 'google/apis/youtube_v3'
if Rails.env.test? || Rails.env.development?
  require './config/environment_variables.rb'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    ENV['GOOGLE_AUTH_CLIENT_ID'],
    ENV['GOOGLE_AUTH_CLIENT_SECRET'], 
    {
      scope: Google::Apis::YoutubeV3::AUTH_YOUTUBE_FORCE_SSL,
      redirect_uri: 'http://localhost:3000/'
    }
  )
end
