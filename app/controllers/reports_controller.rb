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
    @report.picture = report_params[:picture]
    @report.notes = report_params[:notes]
    @report.coffee_made_at = Time.new(
      report_params[:year],
      report_params[:month],
      report_params[:day]
    )

    image_path = @report.picture.store_path @report.picture.filename
    @report.picture.store! image_path

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
    if @report&.id == params[:id].to_i
      @report = nil
    end

    report = Report.find(params[:id])
    if report.present?
      report.picture.file&.delete
      Report.delete(params[:id])
      redirect_to reports_path
    end
  end

  def group_by_year
    sorted_reports = Report.order(coffee_made_at: :desc)
    if sorted_reports.nil?
      return Hash.new
    end

    sorted_reports.each_with_object(Hash.new { |h, k| h[k] = Array.new } ) do |report, hash|
      year = report.coffee_made_at.strftime('%Y')
      hash[year].push(report)
    end
  end
  helper_method :group_by_year

  private

  def report_params
    permitted_params = %i[notes day month year picture]
    report_params, date_params = params.require([:report, :date])

    notes_and_picture = report_params.permit(permitted_params)
    date = date_params.permit(permitted_params)
    notes_and_picture.merge(date.to_h)
  end
end
