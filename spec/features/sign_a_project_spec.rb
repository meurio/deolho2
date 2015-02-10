require "rails_helper"

RSpec.feature "Sign a project" do
  let(:project) { Project.make! }
  let(:user) { User.make! }

  context "When I'm logged in" do
    before { login user, "feature" }

    scenario "When I've never signed this project before", js: true do
      visit project_path(project)
      click_link("sign-project-button")

      expect(project.signers).to include(user)
      expect(page).to_not have_css("#sign-project-button")
      expect(page).to have_css(".thanks-for-signing-this-project")
    end

    scenario "When I've already signed this project" do
      Signature.make! user: user, project: project
      visit project_path(project)

      expect(page).to_not have_css("#sign-project-button")
    end
  end

  context "When I'm not logged in" do
    scenario "When I'm an existing user", js: true do
      visit project_path(project)
      click_link("sign-project-button")
      fill_in "signature[user][first_name]", with: user.first_name
      fill_in "signature[user][last_name]", with: user.last_name
      fill_in "signature[user][email]", with: user.email
      click_button("new-signature-button")

      expect(project.signers).to include(user)
      expect(page).to have_css(".thanks-for-signing-this-project")
    end

    scenario "When I'm a new user", js: true do
      visit project_path(project)
      click_link("sign-project-button")
      fill_in "signature[user][first_name]", with: "Kyle"
      fill_in "signature[user][last_name]", with: "Crane"
      fill_in "signature[user][email]", with: "kylecrane@trashmail.com"
      click_button("new-signature-button")
      new_user = User.find_by(email: "kylecrane@trashmail.com")

      expect(new_user).to_not be_nil
      expect(project.signers).to include(new_user)
      expect(page).to have_css(".thanks-for-signing-this-project")
    end

    scenario "When I submit the signature form with errors", js: true do
      visit project_path(project)
      click_link("sign-project-button")
      click_button("new-signature-button")

      expect(page).to have_css("label.error[for='signature_user_first_name']")
      expect(page).to have_css("label.error[for='signature_user_last_name']")
      expect(page).to have_css("label.error[for='signature_user_email']")
    end
  end
end
