require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
  before { @project = Project.make! }

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

  describe "PUT close_for_contribution" do
    context "when I'm not an admin" do
      let(:user) { User.make! }
      before { session['cas'] = { 'user' => user.email } }

      it "raise an exception" do
        expect {
          put :close_for_contribution, id: @project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      let(:user) { User.make! admin: true }
      before { session['cas'] = { 'user' => user.email } }

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

  describe "PUT reopen_for_contribution" do
    context "when I'm not an admin" do
      let(:user) { User.make! }
      before { session['cas'] = { 'user' => user.email } }

      it "raise an exception" do
        expect {
          put :reopen_for_contribution, id: @project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    context "when I'm an admin" do
      let(:user) { User.make! admin: true }
      before { session['cas'] = { 'user' => user.email } }

      it "should reopen the project for contribution" do
        put :reopen_for_contribution, id: @project.id
        expect(@project.reload.closed_for_contribution?).to be_falsey
      end

      it "should redirects to the project" do
        put :reopen_for_contribution, id: @project.id
        expect(response).to redirect_to(project_path(@project))
      end
    end
  end
end
