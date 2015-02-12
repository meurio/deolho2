require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should have_many :signatures }
  it { should have_many :signers }
  it { should belong_to :category }
  it { should belong_to :organization }
  it { should belong_to :user }
  it { should validate_presence_of :title }
  it { should validate_presence_of :abstract }
  it { should validate_presence_of :category }
  it { should validate_presence_of :organization }
  it { should validate_presence_of :google_drive_url }
  it { should validate_presence_of :google_drive_embed }
  it { should validate_presence_of :user }
  it { should validate_presence_of :image }

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

  describe "#open_for_contribution?" do
    context "when closes_for_contribution_at is bigger than now" do
      subject { Project.make! closes_for_contribution_at: 1.day.from_now }
      it "should be true" do
        expect(subject.open_for_contribution?).to be_truthy
      end
    end

    context "when closes_for_contribution_at is smaller than now" do
      subject { Project.make! closes_for_contribution_at: 1.day.ago }
      it "should be false" do
        expect(subject.open_for_contribution?).to be_falsey
      end
    end
  end

  describe "#processing_in_legislative?" do
    context "when legislative_processing is blank" do
      subject { Project.make! }
      it "should be false" do
        expect(subject.processing_in_legislative?).to be_falsey
      end
    end

    context "when legislative_processing is not blank" do
      subject { Project.make! legislative_processing: "Hello world" }
      it "should be true" do
        expect(subject.processing_in_legislative?).to be_truthy
      end
    end
  end

  describe "#adopted?" do
    subject { Project.make! }

    context "when there is no adopter" do
      it "should be false" do
        expect(subject.adopted?).to be_falsey
      end
    end

    context "when there is at least one adopter" do
      it "should be true" do
        user = User.make!
        subject.adopters << user
        expect(subject.adopted?).to be_truthy
      end
    end
  end
end
