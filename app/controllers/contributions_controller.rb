class ContributionsController < ApplicationController
  authorize_resource

  def create
    user = current_user ||
      User.find_by(email: contribution_params[:user][:email]) ||
      User.create(contribution_params[:user])

    project = Project.find(params[:project_id])
    project.contributions.create user: user
    redirect_to project.google_drive_url
  end

  def contribution_params
    params.require(:contribution).permit(user: [:first_name, :last_name, :email])
  end
end
