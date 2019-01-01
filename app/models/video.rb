class Video < ApplicationRecord
  validates :url, format: { with: /\A#{URI::regexp}\z/, message: 'You must provide a URL' }
end

