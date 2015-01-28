class ProjectsController < ApplicationController
  def index
  end

  def show
    @project = Project.find(params[:id])
  end

  def close_for_contribution
    @project = Project.find(params[:id])
    @project.close_for_contribution
    redirect_to @project
  end
end
