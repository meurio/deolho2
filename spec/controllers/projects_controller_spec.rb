require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  before { @project = Project.make! }

  describe "GET show" do
    it "should assigns @project" do
      get :show, id: @project.id
      expect(assigns(:project)).to be_eql(@project)
    end
  end

  describe "PUT close_for_contribution" do
    it "should close the project for contribution" do
      put :close_for_contribution, id: @project.id
      expect(@project.reload.closed_for_contribution?).to be_truthy
    end

    it "should redirects to the project" do
      put :close_for_contribution, id: @project.id
      expect(response).to redirect_to(project_path(@project))
    end
  end
end
