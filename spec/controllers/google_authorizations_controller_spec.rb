require 'rails_helper'

RSpec.describe GoogleAuthorizationsController, :type => :controller do
  let(:user) { User.make! admin: true }
  before { login user, "controller" }

  describe "#claim" do
    it "should redirect to the Google's authorization request page" do
      get :claim
      expect(response).to redirect_to(/https\:\/\/accounts\.google\.com\/o\/oauth2/)
    end
  end

  describe "#grant" do
    it "should redirect to root when the code is invalid" do
      get :grant, code: "invalid"
      expect(response).to redirect_to(root_path)
    end

    context "when the code is valid" do
      it "should create a new Google authorization when there isn't one" do
        expect {
          get :grant, code: "valid"
        }.to change{GoogleAuthorization.count}.by(1)
      end

      it "should update the existing Google authorization when there is one" do
        ga = GoogleAuthorization.make! user: user
        get :grant, code: "renew"
        expect(ga.reload.access_token).to be_eql("new_access_token")
      end

      it "should redirect to the new project page" do
        get :grant, code: "valid"
        expect(response).to redirect_to(new_project_path)
      end
    end
  end
end
