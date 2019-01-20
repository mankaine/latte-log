class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report = Report.new
    @report.notes = report_params[:notes]
    @report.picture = report_params[:picture]
    @report.coffee_made_at = Time.new(
      report_params[:year],
      report_params[:month],
      report_params[:day]
    )
    @report.save
    redirect_to reports_path
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.picture = report_params[:picture]
    @report.notes = report_params[:notes]
    @report.coffee_made_at = Time.new(
      report_params[:year],
      report_params[:month],
      report_params[:day]
    )
    @report.save
    redirect_to reports_path
  end

  def index
    @reports = Report.all
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    @report = nil

    redirect_to reports_path
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
