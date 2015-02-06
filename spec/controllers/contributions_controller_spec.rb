require 'rails_helper'

RSpec.describe ContributionsController, :type => :controller do
  describe "POST create" do
    let(:user){ User.make! }
    let(:project) { Project.make! }

    context "when the user is logged in" do
      before { login user, 'controller' }

      it "should create a contribution for the current user" do
        post :create, project_id: project.id
        contribution = Contribution.find_by(user_id: user.id, project_id: project.id)
        expect(contribution).to_not be_nil
      end

      it "should redirect to the Google Drive url" do
        post :create, project_id: project.id
        expect(response).to redirect_to(project.google_drive_url)
      end
    end

    context "when the user is not logged in" do
      context "when the user exists" do
        it "should create a contribution for the existing user" do
          post(:create, project_id: project.id, contribution: { user: { email: user.email } })
          contribution = Contribution.find_by(user_id: user.id, project_id: project.id)
          expect(contribution).to_not be_nil
        end
      end

      context "when it's a new user" do
        let(:email){ "kylecrane@trashmail.com" }

        before do
          post(
            :create,
            project_id: project.id,
            contribution: {
              user: {
                email: email,
                first_name: "Kyle",
                last_name: "Crane"
              }
            }
          )
        end

        it "should create a new user" do
          expect(User.where(email: email)).to_not be_empty
        end

        it "should create a contribution for the new user" do
          new_user = User.find_by(email: email)
          contribution = Contribution.find_by(user_id: new_user.id, project_id: project.id)
          expect(contribution).to_not be_nil
        end
      end
    end
  end
end
