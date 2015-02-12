require "rails_helper"

RSpec.feature "Create new project" do
  let (:admin) { User.make! admin: true }
  let (:user) { User.make! }

  context "when I'm an admin" do
    before do
      @category = Category.make!
      @organization = Organization.make!
      login admin, "feature"
      visit root_path
      click_link "new-project-button"
    end

    scenario "when the project form is valid" do
      fill_in "project[title]", with: "My project"
      attach_file "project[image]", "#{Rails.root}/spec/fixtures/files/project.jpg"
      select @category.name, from: "project[category_id]"
      select @organization.city, from: "project[organization_id]"
      fill_in "project[closes_for_contribution_at]", with: Time.now.next_week.strftime("%d/%m/%Y %H:%M")
      fill_in "project[abstract]", with: "My project abstract"
      fill_in "project[google_drive_embed]", with: '<iframe src="https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/pub?embedded=true"></iframe>'
      fill_in "project[google_drive_url]", with: "https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/edit"
      fill_in "project[facebook_share_title]", with: "My project on Facebook"
      fill_in "project[facebook_share_description]", with: "My project description on Facebook"
      attach_file "project[facebook_share_image]", "#{Rails.root}/spec/fixtures/files/project.jpg"
      fill_in "project[twitter_share_message]", with: "My project on Twitter"
      fill_in "project[legislative_processing]", with: "My project processing"
      fill_in "project[legislative_chamber]", with: "ALERJ"
      fill_in "project[email_to_contributor]", with: "My project's email to contributor"
      fill_in "project[email_to_signer]", with: "My project's email to signer"
      fill_in "project[taf_message]", with: "My project's TAF message"
      click_button "submit-project-button"

      new_project = Project.find_by(title: "My project")
      expect(new_project).to_not be_nil
      expect(new_project.facebook_share_title).to_not be_nil
      expect(new_project.facebook_share_description).to_not be_nil
      expect(new_project.facebook_share_image).to_not be_nil
      expect(new_project.twitter_share_message).to_not be_nil
      expect(new_project.legislative_processing).to_not be_nil
      expect(new_project.legislative_chamber).to_not be_nil
      expect(new_project.email_to_contributor).to_not be_nil
      expect(new_project.email_to_signer).to_not be_nil
      expect(new_project.taf_message).to_not be_nil
      expect(current_path).to be_eql(project_path(new_project))
    end

    scenario "when the project form is invalid", js: true do
      click_button "submit-project-button"
      expect(page).to have_css(".title-field.error")
      expect(page).to have_css(".category-id-field.error")
      expect(page).to have_css(".organization-id-field.error")
      expect(page).to have_css(".closes-for-contribution-at-field")
      expect(page).to have_css(".abstract-field")
      expect(page).to have_css(".google-drive-url-field")
      expect(page).to have_css(".google-drive-embed-field")
    end
  end

  scenario "when I'm not an admin", js: true do
    login user, "feature"
    visit root_path
    click_link "new-project-button"

    expect(page).to have_css("#new-project-reveal")
  end
end
