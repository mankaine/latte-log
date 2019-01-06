class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    Rails.logger.debug report_params.inspect
    @report = Report.new
    @report.notes = report_params[:notes]
    @report.coffee_made_at = Time.new(
      report_params[:year],
      report_params[:month],
      report_params[:day]
    )
    @report.picture = report_params[:picture]

    image_path = @report.picture.store_path @report.picture.filename
    @report.picture.store! image_path

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
    @report.picture = report_params[:file]
    @report.notes = report_params[:notes]
    @report.coffee_made_at = Time.new(
      report_params[:year],
      report_params[:month],
      report_params[:day]
    )

    if @report.save
      redirect_to reports_path
    else
      render edit_report_path
    end
  end

  def index
    @reports = Report.all
  end

  def destroy
    if @report&.id == params[:id]
      @report = nil
    end
    report = Report.find(params[:id])
    if report.present?
      report.picture.file.delete
      Report.delete(params[:id])
      redirect_to reports_path
    end
  end

  private

  def report_params
    permitted_params = %i[notes day month year picture]
    report_params, date_params = params.require([:report, :date])

    notes_and_picture = report_params.permit(permitted_params)
    date = date_params.permit(permitted_params)
    notes_and_picture.merge(date.to_h)
  end
end
