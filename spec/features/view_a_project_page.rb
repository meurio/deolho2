require 'rails_helper'

RSpec.feature 'View a project page' do
  let(:project) { Project.make! }

  scenario 'should see the Facebook share button', js: true do
    visit project_path(project)
    expect(page).to have_css('a.share-on-facebook-button')
  end

  scenario 'should see the Twitter share button', js: true do
    visit project_path(project)
    expect(page).to have_css('a.share-on-twitter-button')
  end
end