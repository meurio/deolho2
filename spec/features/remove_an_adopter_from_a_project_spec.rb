require "rails_helper"

RSpec.feature "Remove an adopter from a project" do
  before do
    @admin = User.make! admin: true
    @user = User.make!
    @project = Project.make!
    @adoption = Adoption.make! project: @project
  end

  scenario "when I'm an admin" do
    login @admin, "feature"
    visit project_path(@project)

    expect(page).to have_css(".UserPartial a[data-method='delete']")
    expect(page).to have_css("#adoption-#{@adoption.id}")

    click_link "remove-adoption-#{@adoption.id}"

    expect(current_path).to eq(project_path(@project))
    expect(page).to_not have_css("adoption-#{@adoption.id}")
  end

  scenario "when I'm not a admin" do
    login @user, "feature"
    visit project_path(@project)

    expect(page).to_not have_css("li.user a[data-method='delete']")
  end
end
