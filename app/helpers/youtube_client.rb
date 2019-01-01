module YoutubeClient
  def self.video_url_to_title(service, part, url)
    video_id = YoutubeClient.dig_for_id url
    params = { id: video_id }
    params = params.delete_if { |p, v| v == '' }
    response = service.list_videos(part, params)
    YoutubeClient.parse_response(response)
  end

  def self.dig_for_id(url)
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

  def self.parse_response(response)
    if response.items.count.zero?
      ''
    else
      response.items.first.snippet.title
    end
  end
end

