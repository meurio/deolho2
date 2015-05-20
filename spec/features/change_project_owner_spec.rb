require 'rails_helper'

feature "ChangeProjectOwner", :type => :feature do
  let(:user) { User.make! }
  let(:admin) { User.make! admin: true }
  let(:project) { Project.make! }

  scenario "when I'm not admin" do
    login user, "feature"
    visit project_path(project)

    expect(page).to_not have_css("a[data-reveal-id='change-owner-form']")
  end

  context "when I'm an admin", js: true do
    scenario "when the user exists" do
      login admin, "feature"
      visit project_path(project)
      click_link "Trocar autor"
      fill_in "user_email", with: user.email
      click_button "Trocar autor"

      expect(current_path).to be == project_path(project)
      expect(page).to have_css(".UserPartial-userName", text: user.name)
    end

    scenario "when the user doesn't exists" do
      email = "wrong-email@trashmail.com"
      login admin, "feature"
      visit project_path(project)
      click_link "Trocar autor"
      fill_in "user_email", with: email
      click_button "Trocar autor"

      expect(current_path).to be == project_path(project)
      expect(page).to have_content("Nenhum usuário foi encontrado com o email #{email}")
    end
  end
end
