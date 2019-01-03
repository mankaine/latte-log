class Video < ApplicationRecord
  validates(:url, format: { with: /\A#{URI::regexp}\z/, message: 'Please enter a URL' }) 
end
