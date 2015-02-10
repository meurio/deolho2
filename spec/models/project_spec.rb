require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should have_many :signatures }
  it { should have_many :signers }
  it { should belong_to :category }
  it { should belong_to :organization }
  it { should validate_presence_of :title }
  it { should validate_presence_of :abstract }
  it { should validate_presence_of :category }
  it { should validate_presence_of :organization }
  it { should validate_presence_of :google_drive_url }
  it { should validate_presence_of :google_drive_embed }

  describe ".open_for_contribution" do
    context "when there is no project" do
      it "should be empty" do
        expect(Project.open_for_contribution).to be_empty
      end
    end

    context "when there is one project closed for contribution" do
      it "should be empty" do
        Project.make! closes_for_contribution_at: Time.now
        expect(Project.open_for_contribution).to be_empty
      end
    end

    context "when there is one open project" do
      it "should not be empty" do
        Project.make! closes_for_contribution_at: Time.now + 1.day
        expect(Project.open_for_contribution).to_not be_empty
      end
    end
  end
end
