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

  def close_for_contribution
    @project = Project.find(params[:id])
    @project.close_for_contribution
    redirect_to @project
  end

  def reopen_for_contribution
    @project = Project.find(params[:id])
    @project.reopen_for_contribution
    redirect_to @project
  end

  def project_params
    params.require(:project).permit(:title, :abstract, :category_id, :organization_id,
    :google_drive_embed, :google_drive_url)
  end
end
