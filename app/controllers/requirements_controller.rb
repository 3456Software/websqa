class RequirementsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,    only: [:create, :destroy]

  def create
    @requirement = @project.requirements.build(requirement_params)
    if @requirement.save
      flash[:success] = 'Requirement added'
      redirect_to @project
    else
      redirect_to @project
    end
  end

  def update
  end

  def destroy
  end

  private

    def requirement_params
      params.require(:requirement).permit(:name)
    end
end
