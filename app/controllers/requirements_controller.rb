class RequirementsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user,    only: [:create, :destroy]

  def create
  end

  def update
  end

  def destroy
  end
end
