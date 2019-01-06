class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => %i[report_picture]

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/report-images/#{public_id}"
  end

  def cache_dir
    "uploads/report-images/tmp/#{public_id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    # For Rails 3.1+ asset pipeline compatibility:
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  process :convert => 'jpg'

  # White list of extensions which are allowed to be uploaded.
  def extension_whitelist
     %w(jpg)
   end

  def public_id 
    @public_id ||= Time.now.strftime '%Y%m%d%H%M%S'
  end
end