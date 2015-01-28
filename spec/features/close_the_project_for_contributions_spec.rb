require "rails_helper"

RSpec.feature "Close the project for contributions" do
  let(:project) { Project.make! }
  let(:user) { User.make! }

  before { login(user) }

  scenario "When I'm not an admin" do
    visit project_path project
    expect(page).to_not have_css('#close-contribution-button')
  end

  scenario "When I'm an admin" do
    user.update_attribute :admin, true
    visit project_path project

    click_link "close-contribution-button"

    expect(project.reload.closed_for_contribution_at).to_not be_nil
    expect(page).to_not have_css('#close-contribution-button')
    expect(page).to have_css('#reopen-contribution-button')
  end
end
