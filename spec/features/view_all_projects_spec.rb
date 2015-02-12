require "rails_helper"

RSpec.feature "View all projects" do
  context "when there is no project" do
    it "should display an empty message" do
      visit root_path
      expect(page).to have_css(".projects .empty")
    end
  end

  context "when there is at least one project" do
    it "should display this project" do
      project = Project.make!
      visit root_path

      expect(page).to have_css(".projects .project", text: project.title)
    end
  end
end
