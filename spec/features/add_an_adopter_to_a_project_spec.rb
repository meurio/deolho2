require "rails_helper"

RSpec.feature "Add an adopter to a project" do
  let(:project) { Project.make! google_drive_url: root_path }
  let(:admin) { User.make! admin: true }
  let(:adopter) { User.make! }
  let(:user) { User.make! }

  context "when I'm not logged in" do
    scenario "I should'n see the add adopter button" do
      visit project_path(project)

      expect(page).to_not have_css("#add-adopter-button")
    end
  end

  context "when I'm logged in as a regular user" do
    scenario "I should'n see the add adopter button" do
      login user, "feature"
      visit project_path(project)

      expect(page).to_not have_css("#add-adopter-button")
    end
  end

  context "when I'm logged in as an admin" do
    context "when I submit a valid form", js: true do
      scenario "when the adopter is already an user" do
        login admin, "feature"        

        visit project_path(project)
        click_link "add-adopter-button"

        within("#adoption-form") do
          fill_in "adoption[user][first_name]", with: adopter.first_name
          fill_in "adoption[user][last_name]", with: adopter.last_name
          fill_in "adoption[user][email]", with: adopter.email
          click_button "adoption-submit-button"
        end

        expect(project.adopters).to include(adopter)
      end

      scenario "when the adopter is a new user" do
        login admin, "feature"
        email = "newadopter@trashmail.com"

        visit project_path(project)
        click_link "add-adopter-button"

        within("#adoption-form") do
          fill_in "adoption[user][first_name]", with: "New"
          fill_in "adoption[user][last_name]", with: "Adopter"
          fill_in "adoption[user][email]", with: email
          click_button "adoption-submit-button"
        end

        adopter = User.find_by(email: email)
        expect(adopter).to_not be_nil
        expect(project.adopters).to include(adopter)
      end
    end

    scenario "when I submit an invalid form", js: true do
      login admin, "feature"

      visit project_path(project)
      click_link "add-adopter-button"
      click_button "adoption-submit-button"

      expect(page).to have_css(".first-name-field.error")
      expect(page).to have_css(".last-name-field.error")
      expect(page).to have_css(".email-field.error")
    end

  end  
end
