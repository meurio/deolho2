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

  describe "#taf_fields_class" do
    context "when the project has a customized TAF message" do
      let(:project) { Project.make!(:with_custom_taf_message) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.taf_fields_class).to eql("active")
      end
    end

    context "when the project hasn't a customized TAF message" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.taf_fields_class).to be_nil
      end
    end
  end

  describe "#accepted_field_class" do
    context "when the project is accepted" do
      let(:project) { Project.make!(accepted_at: Time.now) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.accepted_field_class).to eql("active")
      end
    end

    context "when the project is not accepted" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.accepted_field_class).to be_nil
      end
    end
  end

  describe "#rejected_field_class" do
    context "when the project is rejected" do
      let(:project) { Project.make!(rejected_at: Time.now) }

      it "should be 'active'" do
        assign(:project, project)
        expect(helper.rejected_field_class).to eql("active")
      end
    end

    context "when the project is accepted" do
      let(:project) { Project.make!(accepted_at: Time.now) }

      it "should be nil" do
        assign(:project, project)
        expect(helper.rejected_field_class).to be_nil
      end
    end

    context "when the project is not finished" do
      let(:project) { Project.make! }

      it "should be nil" do
        assign(:project, project)
        expect(helper.rejected_field_class).to be_nil
      end
    end
  end

  describe "#meta_title" do
    context "when there is content_for :meta_title" do
      let(:title) { "My title" }
      before do
        allow(helper).to receive(:content_for).with(:meta_title).and_return(title)
      end

      it "should be the content_for :meta_title" do
        expect(helper.meta_title).to be_eql(title)
      end
    end

    context "when there is no content_for :meta_title" do
      it "should be the default meta_title" do
        expect(helper.meta_title).to be_eql(t("meta.title"))
      end
    end
  end

  describe "#meta_description" do
    context "when there is content_for :meta_description" do
      let(:description) { "My description" }
      before do
        allow(helper).to receive(:content_for).with(:meta_description).and_return(description)
      end

      it "should be the content_for :meta_description" do
        expect(helper.meta_description).to be_eql(description)
      end
    end

    context "when there is no content_for :meta_description" do
      it "should be the default meta_description" do
        expect(helper.meta_description).to be_eql(t("meta.description"))
      end
    end
  end

  describe "#meta_image" do
    context "when there is content_for :meta_image" do
      let(:image) { "http://images.com/myimage.png" }
      before do
        allow(helper).to receive(:content_for).with(:meta_image).and_return(image)
      end

      it "should be the content_for :meta_image" do
        expect(helper.meta_image).to be_eql(image)
      end
    end

    context "when there is no content_for :meta_image" do
      it "should be the default meta_image" do
        expect(helper.meta_image).to include(asset_url("legislando.png"))
      end
    end
  end

  describe "#project_status" do
    context "when the project is processing" do
      let(:project) { Project.make!(legislative_processing: "Any value") }

      it "should be 'Tramitando'" do
        expect(helper.project_status(project)).to be_eql("Tramitando")
      end
    end

    context "when the process is adopted" do
      let(:project) { Project.make! }
      before { Adoption.make!(project: project) }

      it "should be 'Adotado'" do
        expect(helper.project_status(project)).to be_eql("Adotado")
      end
    end

    context "when the project is open for contribution" do
      let(:project) { Project.make! }

      it "should be 'Cocriando'" do
        expect(helper.project_status(project)).to be_eql("Cocriando")
      end
    end
  end
end
