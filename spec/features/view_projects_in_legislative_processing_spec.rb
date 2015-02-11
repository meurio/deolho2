require "rails_helper"

RSpec.feature "View projects in legislative processing" do
  context "when there is no project in legislative processing" do
    it "should display an empty message" do
      visit root_path
      expect(page).to have_css(".projects-in-legislative-processing .empty")
    end
  end

  context "when there is at least one project in legislative processing" do
    it "should display this project" do
      project = Project.make! legislative_processing: "My legislative processing"
      visit root_path

      expect(page).to have_css(".projects-in-legislative-processing .project .title", text: project.title)
    end
  end
end
