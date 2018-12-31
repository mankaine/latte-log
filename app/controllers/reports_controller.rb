class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    info = report_params
    @report = Report.new
    @report.image_url = info['image_url']
    @report.notes = info['notes']
    @report.coffee_made_at = DateTime.new(
      info['year'].to_i, info['month'].to_i, info['day'].to_i
    )

    if @report.save
      redirect_to reports_path
    else
      render new_report_path
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])

    if @report.update(report_params)
      redirect_to reports_path
    else
      render edit_report_path
    end
  end

  def index
    @reports = Report.all
  end

  private

  def report_params
    permitted_params = %i[image_url notes day month year]
    params.require(:report).permit(permitted_params)
  end
end

