require 'rails_helper'

RSpec.describe AdoptionsController, :type => :controller do
  let(:user){ User.make! }
  let(:admin) { User.make! admin: true }
  let(:project) { Project.make! }

  describe "POST create" do
    context "when I'm an admin" do
      before { login admin, "controller" }

      context "when the adopter already is an user" do
        it "should create an adoption for the existing user" do
          post(
            :create,
            project_id: project.id,
            adoption: {
              user: {
                email: user.email,
                first_name: user.first_name,
                last_name: user.last_name
              }
            }
          )
          adoption = Adoption.find_by(user_id: user.id, project_id: project.id)
          expect(adoption).to_not be_nil
        end
      end

      context "when the adopter is a new user" do
        let(:email){ "adopter@trashmail.com" }

        before do
          post(
            :create,
            project_id: project.id,
            adoption: {
              user: {
                email: email,
                first_name: "New",
                last_name: "Adopter"
              }
            }
          )
        end

        it "should create a new user" do
          expect(User.where(email: email)).to_not be_empty
        end

        it "should create an adoption for the new adopter" do
          new_adopter = User.find_by(email: email)
          adoption = Adoption.find_by(user_id: new_adopter.id, project_id: project.id)
          expect(adoption).to_not be_nil
        end
      end
    end

    context "when I'm not an admin" do
      before { login user, "controller" }

      it "should raise an exception" do
        expect {
          post(:create, project_id: project.id, adoption: { user: { email: user.email } })
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe "DELETE destroy" do
    context "when I'm an admin" do
      before do
        login admin, "controller"
        @project = Project.make!
        @adoption = Adoption.make! project: @project
      end

      it "should delete the adoption" do
        expect {
          delete(:destroy, project_id: @adoption.project.id, id: @adoption.id)
        }.to change{ Adoption.count }.from(1).to(0)
      end

      it "should redirect to the project page" do
        delete(:destroy, project_id: @adoption.project.id, id: @adoption.id)
        expect(response).to redirect_to project_path(@project, anchor: "adopters")
      end
    end
  end
end
