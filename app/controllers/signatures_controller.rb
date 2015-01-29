class SignaturesController < ApplicationController
  authorize_resource

  def create
    Signature.create project_id: params[:project_id], user_id: current_user.id
    redirect_to project_path(id: params[:project_id])
  end
end
