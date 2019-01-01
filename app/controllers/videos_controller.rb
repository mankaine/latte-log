class VideosController < ApplicationController
  def new
    @video = Video.new
  end 
 
  def index
    @videos = Video.all
  end

  def create
    @video = Video.new video_params 
    video_title = get_video_title video_params['url']
    @video.update(title: video_title)
 
    if @video.save
      redirect_to videos_path 
    else
      render new_video_path 
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def show
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    video_title = get_video_title params['video']['url']
    youtube_pattern = /youtube\.com/

    if @video.update(video_params)
      @video.update(title: video_title)
      redirect_to videos_path 
    else
      render new_video_path
    end 
  end

  def destroy
    if @video&.id == params[:id]
      @video = nil
    end
    if Video.find(params[:id])
      Video.destroy(params[:id])
      redirect_to videos_path
    end
  end

  private

  def video_params
    permitted_params = %i[url notes]
    params.require(:video).permit(permitted_params)
  end

  private 

  def get_video_title(url)
    video_title = 'Video'

    youtube_pattern = /youtube\.com/
    if youtube_pattern.match url
      video_title = YoutubeClient.video_url_to_title(
        $youtube_service, 'snippet', url
      )
    end

    video_title
  end
end

