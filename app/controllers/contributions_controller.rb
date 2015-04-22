class ContributionsController < ApplicationController
  authorize_resource

  def create
    project = Project.find(params[:project_id])
    user = current_user_or_find_or_create(contribution_params, organization_id: project.organization_id)
    contribution = project.contributions.create user_id: user.id

    if contribution.persisted?
      Notifier.thanks_for_contributing(contribution).deliver_later
    end

    redirect_to project_path(project, contribution_created: true, anchor: "thanks-for-contributing-to-this-project")
  end

  def contribution_params
    if params[:contribution].present?
      params.require(:contribution).permit(user: [:first_name, :last_name, :email])
    end
  end
end
