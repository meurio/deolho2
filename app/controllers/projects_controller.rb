class ProjectsController < ApplicationController
  authorize_resource

  def index
    @open_projects = Project.open_for_contribution
    @projects_in_legislative_processing = Project.processing_in_legislative
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.user = current_user
    @project.save
    redirect_to @project
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes(project_params)
    redirect_to project
  end

  def show
    @project = Project.find(params[:id])
    @signature = Signature.new
    @contribution = Contribution.new
  end

  def project_params
    params.require(:project).permit(:title, :abstract, :category_id, :organization_id,
    :google_drive_embed, :google_drive_url, :closes_for_contribution_at, :facebook_share_image,
    :facebook_share_description, :facebook_share_title, :twitter_share_message, :legislative_chamber,
    :legislative_processing, :email_to_signer, :email_to_contributor, :taf_message)
  end
end
