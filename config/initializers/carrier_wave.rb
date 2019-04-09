module CarrierWave
  module MiniMagick
    def optimize(percentage)
      manipulate! do |image|
        image.quality = percentage.to_s
        image = yield(image) if block_given? 
        image
      end
    end
  end
end

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
