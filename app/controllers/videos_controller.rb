class VideosController < ApplicationController
  def new
    @video = Video.new
  end 
 
  def index
    @videos = Video.all
  end

  def create
    @video = Video.new video_params

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
   
    if @video.update(video_params)
      redirect_to videos_path 
    else
      render edit_video_path
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
    permitted_params = %i[url notes title]
    params.require(:video).permit(permitted_params)
  end
end
