class Report < ApplicationRecord
  mount_uploader :picture, ImageUploader 

  before_destroy :delete_image
  before_save :store_image_path

  def self.group_by_year
    if Report.count.zero?
      return Hash.new
    end

    sorted_reports = Report.order(coffee_made_at: :desc)
    sorted_reports.each_with_object(HashArray.new) do |report, hash|
      year = report.coffee_made_at.strftime('%Y')
      hash.push(year, report)
    end.collection
  end
 
  private
  def delete_image
    picture.file&.delete
  end

  def store_image_path
    image_path = picture.store_path picture.filename
    picture.store! image_path
  end
end
