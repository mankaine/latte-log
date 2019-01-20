class VideosController < ApplicationController
  before_action :redirect_cancel, :only => [:create, :update]

  def new
    @video = Video.new
  end 
 
  def index
    @videos = Video.order('created_at DESC')
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
      render new_video_path 
    end 
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    @video = nil

    redirect_to reports_path
  end

  def redirect_cancel
    redirect_to videos_path if params[:cancel]
  end

  private

  def video_params
    permitted_params = %i[url notes title]
    params.require(:video).permit(permitted_params)
  end
end
