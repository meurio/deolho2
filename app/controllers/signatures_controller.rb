class SignaturesController < ApplicationController
  authorize_resource

  def create
    user = current_user_or_find_or_create(signature_params)
    project = Project.find(params[:project_id])
    Signature.create project_id: project.id, user_id: user.id
    redirect_to project_path(project, anchor: "thanks-for-signing-this-project")
  end

  def signature_params
    if params[:signature].present?
      params.require(:signature).permit(user: [:first_name, :last_name, :email])
    end
  end
end
