class BugReportsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,    only: [:destroy]

  def create
    @bug_report = project.bug_reports.build(create_params)
    if @bug_report.save
      flash[:success] = 'Bug reported.'
      redirect_to project
    else
      flash[:danger] = 'There was an error reporting the bug.'
      redirect_to project
    end
  end

  def update
    @bug_report = BugReport.find_by(id: params[:id])
    if @bug_report.update_attributes(update_params)
      flash[:success] = 'Bug resolved.'
      redirect_to @bug_report.project
    else
      redirect_to @bug_report.project
    end
  end

  def destroy
    @bug_report = BugReport.find_by(id: params[:id])
    @bug_report.destroy
    redirect_to @bug_report.project
  end

  private

  def create_params
    params.require(:bug_report).permit(:name)
  end

  def update_params
    params.require(:bug_report).permit(:status, :date_completed)
  end

  def project
    Project.find(params[:bug_report][:project_id])
  end
end
