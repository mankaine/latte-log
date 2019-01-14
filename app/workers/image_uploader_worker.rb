class ImageUploaderWorker
  include Sidekiq::Worker

  def perform(cache_id, original_name)
    image_uploader = ImageUploader.new

    image_uploader.retrieve_from_cache! cache_id
    Rails.logger.debug(image_uploader.cache_path)
    path = cached_path(image_uploader.cache_path)
    byebug
    image_uploader.store! File.open(path)
    byebug
  end


  private
  
  def cached_path(cache_dir)
    file_names = Dir.entries(cache_dir).select do |file|
      !(['.', '..'].include? file)
    end
    cache_dir + file_names[0]
  end
end
