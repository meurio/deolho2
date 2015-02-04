require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#legislative_fields_class" do
    context "when the project has legislative fields changed" do
      let(:project) { Project.make!(:with_legislative_fields_changed) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.legislative_fields_class).to eql("active")
      end
    end

    context "when the project hasn't legislative fields changed" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.legislative_fields_class).to be_nil
      end
    end
  end

  describe "#facebook_share_fields_class" do
    context "when the project has facebook share content customized" do
      let(:project) { Project.make!(:with_custom_facebook_share_content) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.facebook_share_fields_class).to eql("active")
      end
    end

    context "when the project hasn't facebook share content customized" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.facebook_share_fields_class).to be_nil
      end
    end
  end

  describe "#twitter_share_fields_class" do
    context "when the project has twitter share content customized" do
      let(:project) { Project.make!(:with_custom_twitter_message) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.twitter_share_fields_class).to eql("active")
      end
    end

    context "when the project hasn't twitter share content customized" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.twitter_share_fields_class).to be_nil
      end
    end
  end

  describe "#email_fields_class" do
    context "when the project has email content customized" do
      let(:project) { Project.make!(:with_custom_email) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.email_fields_class).to eql("active")
      end
    end

    context "when the project hasn't email content customized" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.email_fields_class).to be_nil
      end
    end
  end
end
