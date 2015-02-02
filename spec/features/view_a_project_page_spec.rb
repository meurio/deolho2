require 'rails_helper'

RSpec.feature 'View a project page' do
  let(:project) { Project.make! }
  before { visit project_path(project) }

  scenario 'should see the Facebook share button' do
    expect(page).to have_css('a.share-on-facebook-button')
  end

  scenario 'should see the Twitter share button' do
    expect(page).to have_css('a.share-on-twitter-button')
  end

  scenario 'should see the adopt project button' do
    expect(page).to have_css('a#adopt-project-button')
  end

  scenario 'should see the adopt project message', js: true do
    page.click_link 'adopt-project-button'
    expect(page).to have_css('#adopt.open')
  end
end