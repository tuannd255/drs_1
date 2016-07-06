class ReportsController < ApplicationController
  before_action :logged_in_user, except: [:destroy, :update, :edit]
  
  def index
    @reports = if params[:search]
      Report.search_by_date_or_progress params[:search]
    else
      Report.paginate page: params[:page]
    end
  end

  def new
    @report = Report.new
    @reports = current_user.feed_report.oder_by_time
      .paginate page: params[:page], per_page: Settings.perpage
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:success] = t "report.created"
      redirect_to new_report_path
    else
      redirect_to new_report_path
    end
  end

  private
  def report_params
    params.require(:report).permit :report_date, :progress, 
      :achievement, :next_day_plan, :comment_question
  end
end
