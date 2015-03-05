class AdoptionsController < ApplicationController
  authorize_resource

  def create
    user = User.find_by(email: user_params[:email]) ||
      User.create(user_params.merge(password: SecureRandom.hex))

    project = Project.find(params[:project_id])
    adoption = project.adoptions.create user_id: user.id

    redirect_to project_path(project, anchor: "adopters")
  end

  def destroy
    Adoption.find(params[:id]).destroy
    project = Project.find(params[:project_id])
    redirect_to project_path(project, anchor: "adopters")
  end

  def adoption_params
    if params[:adoption].present?
      params.require(:adoption).permit(user: [:first_name, :last_name, :email])
    end
  end

  def user_params
    adoption_params[:user]
  end
end
