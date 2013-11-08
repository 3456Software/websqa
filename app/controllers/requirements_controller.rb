class RequirementsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,    only: [:create, :destroy]

  def create
    @requirement = project.requirements.build(create_params)
    if @requirement.save
      flash[:success] = 'Requirement added.'
      redirect_to project
    else
      flash[:danger] = 'There was an error adding requirement.'
      # Show errors better
      redirect_to project
    end
  end

  def update
    @requirement = Requirement.find_by(id: params[:id])
    if @requirement.update_attributes(update_params)
      flash[:success] = "Requirement met."
      redirect_to @requirement.project
    else
      redirect_to @requirement.project
    end
  end

  def destroy
    @requirement = Requirement.find_by(id: params[:id])
    @requirement.destroy
    redirect_to @requirement.project
  end

  private

    # Secure params
    def create_params
      params.require(:requirement).permit(:name)
    end

    def update_params
      params.require(:requirement).permit(:status, :date_completed)
    end

    # Find the appropriate (owning) project
    def project
      Project.find(params[:requirement][:project_id])
    end

end
