class AccessesController < ApplicationController
  before_action :admin_user

  def create
    @project = Project.find(params[:access][:project_id])
    @user = User.find(params[:access][:member_id])
    @project.add_member!(@user)
    redirect_to project_members_path(@project)
  end

  def destroy
    @project = Access.find(params[:id]).project
    @user = Access.find(params[:id]).member
    @project.remove_member!(@user)
    redirect_to project_members_path(@project)
  end
end
