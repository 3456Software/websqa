class ProjectsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = 'Project created'
      redirect_to @project
    else
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = 'Project updated'
      redirect_to @project
    else
      render 'edit'
    end
  end

  def index
    @projects = Project.paginate(page: params[:page], per_page: 10)
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = 'Project deleted.'
    redirect_to projects_url
  end

  private

    def project_params
      params.require(:project).permit(:title, :desc)
    end

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        flash[:warning] = 'Please sign in.'
        redirect_to signin_url
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
