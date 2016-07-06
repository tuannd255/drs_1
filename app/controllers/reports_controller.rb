class ReportsController < ApplicationController
  before_action :logged_in_user, except: [:destroy, :update, :edit]
  
  def index
    @report = Report.new
    load_reports
  end

  def new
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:success] = t "report.created"
      redirect_to reports_path
    else
      load_reports
      render :index
    end
  end

  def show
    @report = current_user.reports.build    
    @feed_items = current_user.feed_report.oder_by_time
      .paginate page: params[:page], per_page: Settings.perpage
  end

  private
  def report_params
    params.require(:report).permit :report_date, :progress, 
      :achievement, :next_day_plan, :comment_question
  end

  def load_reports
    @reports = Report.all.paginate page: params[:page]
  end
end
