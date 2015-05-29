require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  before { @project = Project.make! }
  let(:user) { User.make! }
  let(:admin) { User.make! admin: true }
  let(:category) { Category.make! }
  let(:organization) { Organization.make! }
  before { GoogleAuthorization.make! user: admin }

  describe "GET new" do
    context "when I'm not an admin" do
      before { login user, "controller" }

      it "should raise an exception" do
        expect {
          get :new
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      before { login admin, "controller" }

      it "should assign @project" do
        get :new
        expect(assigns(:project)).to be_a Project
      end
    end
  end

  describe "POST create" do
    context "when I'm not an admin" do
      before { login(user, "controller") }

      it "should raise an exception" do
        expect {
          post :create
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      before { login(admin, "controller") }

      it "should create a new project" do
        expect {
          post :create, project_params
        }.to change{Project.count}.by(1)
      end

      it "should redirect to the new project page" do
        post :create, project_params
        project = Project.order(:id).last
        expect(response).to redirect_to(project_path(project))
      end
    end
  end

  describe "GET edit" do
    context "when I'm not an admin" do
      it "should raise an exception" do
        login user, "controller"
        expect {
          get :edit, id: @project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      it "should assign @project" do
        login admin, "controller"
        get :edit, id: @project.id
        expect(assigns(:project)).to be_eql(@project)
      end
    end
  end

  describe "PUT update" do
    context "when I'm not an admin" do
      it "should raise an exception" do
        login user, "controller"
        expect {
          put :update, id: @project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      before { login admin, "controller" }

      it "should update the project" do
        new_title = "New title"
        put :update, id: @project.id, project: { title: new_title }
        expect(@project.reload.title).to be_eql(new_title)
      end

      it "should redirect to the project page" do
        put :update, id: @project.id, project: project_params[:project]
        expect(response).to redirect_to(project_path(@project))
      end
    end
  end

  describe "GET show" do
    it "should assign @project" do
      get :show, id: @project.id
      expect(assigns(:project)).to be_eql(@project)
    end

    it "should assign @signature" do
      get :show, id: @project.id
      expect(assigns(:signature)).to be_a Signature
    end
  end

  describe "GET index" do
    it "should assign @projects" do
      get :index
      expect(assigns(:projects)).to include(@project)
    end
  end

  def project_params
    {
      project: {
        title: "My project",
        abstract: "My abstract",
        category_id: category.id,
        organization_id: organization.id,
        google_drive_embed: '<iframe src="https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/pub?embedded=true"></iframe>',
        google_drive_url: "https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/edit",
        closes_for_contribution_at: Time.now.next_week,
        image: fixture_file_upload("files/project.jpg")
      }
    }
  end
end
