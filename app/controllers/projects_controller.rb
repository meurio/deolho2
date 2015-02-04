class ProjectsController < ApplicationController
  authorize_resource

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create project_params
    redirect_to @project
  end

  def show
    @project = Project.find(params[:id])
    @signature = Signature.new
  end

  def project_params
    params.require(:project).permit(:title, :abstract, :category_id, :organization_id,
    :google_drive_embed, :google_drive_url, :closes_for_contribution_at, :facebook_share_image,
    :facebook_share_description, :facebook_share_title, :twitter_share_message, :legislative_chamber,
    :legislative_processing, :email_to_signer, :email_to_contributor)
  end
end
