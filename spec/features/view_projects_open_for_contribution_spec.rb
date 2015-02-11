require "rails_helper"

RSpec.feature "View projects open for contribution" do
  context "when there is no project open for contribution" do
    it "should display a empty message" do
      visit root_path
      expect(page).to have_css(".projects-open-for-contribution .empty")
    end
  end

  context "when there is at least one project open for contribution" do
    it "should display this project" do
      project = Project.make!
      visit root_path

      expect(page).to have_css(".project .title", text: project.title)
    end
  end
end
