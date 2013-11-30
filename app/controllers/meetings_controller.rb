class MeetingsController < ApplicationController
  before_action :signed_in_user

  def create
    @meeting = project.meetings.build(create_params)
    if @meeting.save
      flash[:success] = 'Meeting logged.'
      redirect_to project
    else
      flash[:danger] = 'There was an error logging the meeting.'
      redirect_to project
    end
  end

  def destroy
    @meeting = Meeting.find_by(id: params[:id])
    @meeting.destroy
    redirect_to @meeting.project
  end

  private

  def create_params
    params.require(:meeting).permit(:name, :date_string)
  end

  def project
    Project.find(params[:meeting][:project_id])
  end
end
