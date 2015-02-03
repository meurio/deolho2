require "rails_helper"

RSpec.feature "Reopen the project for contributions" do
  let(:project) { Project.make! closed_for_contribution_at: Time.now }
  let(:admin) { User.make! admin: true }

  scenario "When I'm not an admin" do
    visit project_path project
    expect(page).to_not have_css('#reopen-contribution-button')
  end

  scenario "When I'm an admin" do
    login(admin)
    visit project_path project

    click_link("reopen-contribution-button")

    expect(project.reload.closed_for_contribution_at).to be_nil
    expect(page).to_not have_css('#reopen-contribution-button')
    expect(page).to have_css('#close-contribution-button')
  end
end
