require "rails_helper"

RSpec.feature "Edit a project" do
  let(:admin) { User.make! admin: true }
  let(:user) { User.make! }
  let(:project) { Project.make! }
  let(:project_with_legislative_fields_changed) { Project.make!(:with_legislative_fields_changed) }
  let(:project_with_custom_facebook_share_content) { Project.make!(:with_custom_facebook_share_content) }
  let(:project_with_custom_email) { Project.make!(:with_custom_email) }
  let(:project_with_custom_twitter_message) { Project.make!(:with_custom_twitter_message) }
  let(:project_with_custom_taf_message) { Project.make!(:with_custom_taf_message) }

  context "when I'm an admin" do
    before { login admin, "feature" }

    scenario "when the legislative fields were changed" do
      visit project_path(project_with_legislative_fields_changed)
      click_link "edit-project-button"

      expect(page).to have_css("#legislative-fields.active")
    end

    scenario "when the Facebook share content was customized" do
      visit project_path(project_with_custom_facebook_share_content)
      click_link "edit-project-button"

      expect(page).to have_css("#facebook-share-fields.active")
    end

    scenario "when the Twitter message was customized" do
      visit project_path(project_with_custom_twitter_message)
      click_link "edit-project-button"

      expect(page).to have_css("#twitter-share-fields.active")
    end

    scenario "when the email content was customized" do
      visit project_path(project_with_custom_email)
      click_link "edit-project-button"

      expect(page).to have_css("#email-fields.active")
    end

    scenario "when the TAF message was customized" do
      visit project_path(project_with_custom_taf_message)
      click_link "edit-project-button"

      expect(page).to have_css("#taf-fields.active")
    end

    scenario "when I update the project name" do
      new_title = "My project's new title"
      visit project_path(project)
      click_link "edit-project-button"
      fill_in "project[title]", with: new_title
      click_button "submit-project-button"

      expect(project.reload.title).to be_eql(new_title)
      expect(current_path).to be_eql(project_path(project))
    end
  end

  scenario "when I'm not an admin" do
    login user, "feature"
    visit project_path(project)

    expect(page).to_not have_css("#edit-project-button")
  end
end
