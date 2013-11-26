# draft of defect report update controller,
# based on requirements controller

class DefectUpdatesController < ApplicationController
  before_action :signed_in_user

  def create
    @defect_update = project.defect_updates.build(create_params)
    if @defect_update.save
      flash[:success] = 'Defect Report Update added.'
      redirect_to project
    else
      flash[:danger] = 'There was an error adding Defect Report update.'
      redirect_to project
    end
  end

  def destroy
    @defect_update = Defect.find_by(id: params[:id])
    @defect_update.destroy
    redirect_to @defect_update.project
  end

  private

  def create_params
    params.require(:defect_update).permit(:name)
  end

  def update_params
    params.require(:defect_update).permit(:status, :date_completed)
  end

  def project
    Project.find(params[:defect_update][:project_id])
  end
end
