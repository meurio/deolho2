require "rails_helper"

RSpec.feature "Create new project" do
  context "when I'm an admin" do
    let (:admin) { User.make! admin: true }

    before do
      @category = Category.make!
      @organization = Organization.make!
      login admin
      visit root_path
      click_link "new-project-button"
    end

    scenario "when the project form is valid" do
      fill_in "project[title]", with: "My project"
      select @category.name, from: "project[category_id]"
      select @organization.city, from: "project[organization_id]"
      fill_in "project[closes_for_contribution_at]", with: Time.now.next_week.strftime("%d/%m/%Y %H:%M")
      fill_in "project[abstract]", with: "My project abstract"
      fill_in "project[google_drive_embed]", with: '<iframe src="https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/pub?embedded=true"></iframe>'
      fill_in "project[google_drive_url]", with: "https://docs.google.com/document/d/1UcQp8j3N_nk75vyTWbbuFOlp5yswjeVg218CZo_-rho/edit"
      fill_in "project[facebook_share_title]", with: "My project on Facebook"
      fill_in "project[facebook_share_description]", with: "My project description on Facebook"
      attach_file "project[facebook_share_image]", "#{Rails.root}/spec/support/images/facebook_share_image.jpg"
      fill_in "project[twitter_share_message]", with: "My project on Twitter"
      click_button "new-project-submit-button"

      new_project = Project.find_by(title: "My project")
      expect(new_project).to_not be_nil
      expect(new_project.facebook_share_title).to_not be_nil
      expect(new_project.facebook_share_description).to_not be_nil
      expect(new_project.facebook_share_image).to_not be_nil
      expect(new_project.twitter_share_message).to_not be_nil
      expect(current_path).to be_eql(project_path(new_project))
    end

    scenario "when the project form is invalid" do
    end
  end

  scenario "when I'm not an admin" do

  end
end
