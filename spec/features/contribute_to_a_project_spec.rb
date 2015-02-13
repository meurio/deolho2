require "rails_helper"

RSpec.feature "Contribute to a project" do
  let(:project) { Project.make! google_drive_url: root_path }
  let(:user) { User.make! }

  scenario "when I'm logged in" do
    login user, "feature"
    visit project_path(project)
    click_link "contribution-button"

    expect(project.contributors).to include(user)
  end

  context "when I'm not logged in" do
    context "when I submit a valid form", js: true do
      scenario "when I'm a new user" do
        email = "hansolo@trashmail.com"
        visit project_path(project)
        click_link "contribution-button"

        within("#contribution-form") do
          fill_in "contribution[user][first_name]", with: "Han"
          fill_in "contribution[user][last_name]", with: "Solo"
          fill_in "contribution[user][email]", with: email
          click_button "contribution-submit-button"
        end

        new_user = User.find_by(email: email)
        expect(new_user).to_not be_nil
        expect(project.contributors).to include(new_user)
      end

      scenario "when I'm an existing user", js: true do
        visit project_path(project)
        click_link "contribution-button"

        within("#contribution-form") do
          fill_in "contribution[user][first_name]", with: user.first_name
          fill_in "contribution[user][last_name]", with: user.last_name
          fill_in "contribution[user][email]", with: user.email
          click_button "contribution-submit-button"
        end

        expect(project.contributors).to include(user)
      end
    end

    scenario "when I submit an invalid form", js: true do
      visit project_path(project)
      click_link "contribution-button"
      click_button "contribution-submit-button"

      expect(page).to have_css(".first-name-field.error")
      expect(page).to have_css(".last-name-field.error")
      expect(page).to have_css(".email-field.error")
    end
  end
end
