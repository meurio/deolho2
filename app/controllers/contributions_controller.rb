class ContributionsController < ApplicationController
  authorize_resource

  def create
    user = current_user_or_find_or_create(contribution_params)
    project = Project.find(params[:project_id])
    project.contributions.create user: user
    redirect_to project.google_drive_url
  end

  def contribution_params
    if params[:contribution].present?
      params.require(:contribution).permit(user: [:first_name, :last_name, :email])
    end
  end
end
