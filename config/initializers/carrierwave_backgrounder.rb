CarrierWave::Backgrounder.configure do |config|
  config.backend :sidekiq, queue: :carrierwave, size: 3
end
