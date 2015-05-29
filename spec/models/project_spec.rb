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

  describe "#open?" do
    context "when closes_for_contribution_at is bigger than now" do
      subject { Project.make! closes_for_contribution_at: 1.day.from_now }
      it "should be true" do
        expect(subject.open?).to be_truthy
      end
    end

    context "when closes_for_contribution_at is smaller than now" do
      subject { Project.make! closes_for_contribution_at: 1.day.ago }
      it "should be false" do
        expect(subject.open?).to be_falsey
      end
    end
  end

  describe "#processing?" do
    context "when legislative_processing is blank" do
      subject { Project.make! }
      it "should be false" do
        expect(subject.processing?).to be_falsey
      end
    end

    context "when legislative_processing is not blank" do
      subject { Project.make! legislative_processing: "Hello world" }
      it "should be true" do
        expect(subject.processing?).to be_truthy
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

  describe "#accepted?" do
    subject { Project.make! }

    context "when the project is accepted" do
      it "should be true" do
        subject.update accepted_at: Time.now
        expect(subject.accepted?).to be_truthy
      end
    end

    context "when the project is not accepted" do
      it "should be false" do
        expect(subject.accepted?).to be_falsey
      end
    end
  end

  describe "#rejected?" do
    subject { Project.make! }

    context "when the project is rejected" do
      it "should be true" do
        subject.update rejected_at: Time.now
        expect(subject.rejected?).to be_truthy
      end
    end

    context "when the project is not rejected" do
      it "should be false" do
        expect(subject.rejected?).to be_falsey
      end
    end
  end

  describe "#finished?" do
    subject { Project.make! }

    context "when the project is accepted" do
      it "should be true" do
        subject.update accepted_at: Time.now
        expect(subject.finished?).to be_truthy
      end
    end

    context "when the project is rejected" do
      it "should be true" do
        subject.update rejected_at: Time.now
        expect(subject.finished?).to be_truthy
      end
    end

    context "when the project was not voted yet" do
      it "should be false" do
        expect(subject.finished?).to be_falsey
      end
    end
  end

  describe "#copy_google_drive_file" do
    let(:user) { User.make! }
    let(:access_token) { "123" }
    let(:title) { "My Project" }
    let(:file) { double(:file) }
    let(:alternate_link) { "alternate_link" }
    let(:embed_link) { "embedLink" }
    let(:file_id) { "file_id" }
    subject { Project.make user: user, title: title }

    before do
      GoogleAuthorization.make! user: user, access_token: access_token
      allow(GoogleDrive).to receive(:insert_permission)
      allow(file).to receive(:data).and_return({
        "alternateLink" => alternate_link,
        "embedLink" => embed_link,
        "id" => file_id
      })

      allow(GoogleDrive).to receive(:copy_file).and_return(file)
    end

    it "should copy a Google Drive file" do
      expect(GoogleDrive).to receive(:copy_file).with(
        file_id: ENV["GOOGLE_DRIVE_FILE_ID"],
        title: title,
        access_token: access_token
      ).and_return(file)

      subject.copy_google_drive_file
    end

    it "should set Google Drive fields" do
      subject.copy_google_drive_file
      expect(subject.google_drive_url).to be_eql(alternate_link)
      expect(subject.google_drive_embed).to match(embed_link)
    end

    it "should insert a Google Drive permission" do
      expect(GoogleDrive).to receive(:insert_permission).with(
        file_id: file_id,
        role: "reader",
        type: "anyone",
        additional_roles: ["commenter"],
        access_token: access_token
      )

      subject.copy_google_drive_file
    end
  end
end
