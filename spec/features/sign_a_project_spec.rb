require "rails_helper"

RSpec.feature "Sign a project" do
  context "When I'm logged in" do
    scenario "When I've never signed this project before" do
      user = User.make!
      project = Project.make!

      login(user)
      visit project_path(project)
      click_link("sign-project-button")

      expect(project.signers).to include(user)
      expect(page).to_not have_css("#sign-project-button")
      expect(page).to have_css(".thanks-for-signing-this-project")
    end

    scenario "When I've already signed this project" do
    end
  end

  context "When I'm not logged in" do
    scenario "When I'm an existing user" do
    end

    scenario "When I'm a new user" do
    end

    scenario "When I submit the signature form with errors" do
    end
  end
end
