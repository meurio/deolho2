class SignaturesController < ApplicationController
  authorize_resource

  def create
    user = current_user || User.find_by(email: params[:signature][:user][:email])
    project = Project.find(params[:project_id])
    Signature.create project_id: project.id, user_id: user.id
    redirect_to project_path(project, anchor: "thanks-for-signing-this-project")
  end
end
