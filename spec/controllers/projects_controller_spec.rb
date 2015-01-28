require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  describe "GET show" do
    before { @project = Project.make! }

    it "should assigns @project" do
      get :show, id: @project.id
      expect(assigns(:project)).to be_eql(@project)
    end
  end
end
