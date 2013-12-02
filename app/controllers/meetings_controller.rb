class MeetingsController < ApplicationController
  before_action :signed_in_user
  before_action :member, only: [:create]
  before_action :admin_user,    only: [:destroy]

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
    params.require(:meeting).permit(:name, :date_string, :description)
  end

  def project
    Project.find(params[:meeting][:project_id])
  end

  # Before filters
  def member
    unless project.member?(current_user) || current_user.admin?
      flash[:warning] = 'You do not have access to this project.'
      redirect_to root_url
    end
  end
end
