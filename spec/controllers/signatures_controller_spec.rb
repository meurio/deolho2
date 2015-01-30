require 'rails_helper'

RSpec.describe SignaturesController, :type => :controller do
  describe "POST create" do
    let(:project) { Project.make! }
    let(:user) { User.make! }

    context "when the user is logged in" do
      before { session['cas'] = { 'user' => user.email } }

      it "should create a new signature for the logged in user" do
        post :create, project_id: project.id

        expect(
          Signature.where(project_id: project.id, user_id: user.id)
        ).to_not be_empty
      end

      it "should redirect to the project page" do
        post :create, project_id: project.id
        expect(response).to redirect_to(project_path(project, anchor: "thanks-for-signing-this-project"))
      end
    end

    context "when the user is not logged in" do
      context "when the user exists" do
        it "should create a new signature for the existing user" do
          post :create, project_id: project.id, signature: { user: { email: user.email } }

          expect(
            Signature.where(project_id: project.id, user_id: user.id)
          ).to_not be_empty
        end
      end

      context "when the user is new" do
        let(:email){ "kylecrane@trashmail.com" }

        it "should create a new user" do
          expect{
            post :create, project_id: project.id, signature: { user: { email: email } }
          }.to change{ User.count }.by(1)
        end

        it "should create a new signature for the new user" do
          post :create, project_id: project.id, signature: { user: { email: email } }
          new_user = User.find_by(email: email)

          expect(
            Signature.where(project_id: project.id, user_id: new_user.id)
          ).to_not be_empty
        end
      end
    end
  end
end
