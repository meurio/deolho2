class AdoptionsController < ApplicationController
  authorize_resource

  def create
    user = User.create_with(adoption_params[:user].merge(password: SecureRandom.hex)).find_or_create_by(email: adoption_params[:user][:email])
    project = Project.find(params[:project_id])
    adoption = project.adoptions.create user: user

    redirect_to project_path(project, anchor: "adopters")
  end

  def adoption_params
    if params[:adoption].present?
      params.require(:adoption).permit(user: [:first_name, :last_name, :email])
    end
  end
end
