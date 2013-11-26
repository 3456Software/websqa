# draft of defect report controller,
# based on requirements controller

class DefectsController < ApplicationController
  before_action :signed_in_user

  def create
    @defect = project.defects.build(create_params)
    if @defect.save
      flash[:success] = 'Defect Report added.'
      redirect_to project
    else
      flash[:danger] = 'There was an error adding Defect Report.'
      redirect_to project
    end
  end

  def update
    @defect = Defect.find_by(id: params[:id])
    if @defect.update_attributes(update_params)
      flash[:success] = 'Defect Resolved.'
      redirect_to @defect.project
    else
      redirect_to @defect.project
    end
  end

  def destroy
    @defect = Defect.find_by(id: params[:id])
    @defect.destroy
    redirect_to @defect.project
  end

  private

  def create_params
    params.require(:defect).permit(:name)
  end

  def update_params
    params.require(:defect).permit(:status, :date_completed)
  end

  def project
    Project.find(params[:defect][:project_id])
  end
end
