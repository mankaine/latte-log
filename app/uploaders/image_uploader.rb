class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  process :convert => 'png'
  process :tags => %i[report_picture]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/report-images/#{public_id}"
  end

  def cache_dir
    'uploads'
  end

  # Process files as they are uploaded:
  process :convert => 'jpg'

  version :index_view do
    height = 350
    width = height * 3 / 4
    process :optimize => 15
  end

  version :edit_view do
    height = 300
    width = height * 3 / 4
    process resize_to_fit: [height, width]
    process :optimize => 20
  end

  # White list of extensions which are allowed to be uploaded.
  def extension_whitelist
     %w(jpg)
   end

  def public_id 
    @public_id ||= Time.now.strftime '%Y%m%d%H%M%S'
  end
end
