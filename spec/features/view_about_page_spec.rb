require "rails_helper"

RSpec.feature "View about page" do
  scenario "when I visit the about page" do
    visit about_path
    expect(page).to have_css(".pages.about")
  end
end
