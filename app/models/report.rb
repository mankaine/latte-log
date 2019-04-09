class Report < ApplicationRecord
  mount_uploader :picture, ImageUploader 

  before_destroy :delete_image

  def self.group_by_year
    if Report.count.zero?
      return Hash.new
    end

    sorted_reports = Report.order(coffee_made_at: :desc)
    sorted_reports.each_with_object(HashArray.new) do |report, hash|
      if report and report.coffee_made_at
        year = report.coffee_made_at.strftime('%Y')
        hash.push(year, report)
      end
    end.hash
  end
 
  private
  def delete_image
    picture.file&.delete
  end
end
