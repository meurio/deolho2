require "rails_helper"

RSpec.describe Notifier, :type => :mailer do
  describe ".thanks_for_contributing" do
    let(:contribution){ Contribution.make! }

    it "should be sent to the contributor" do
      email = Notifier.thanks_for_contributing(contribution).deliver_now
      expect(email.to).to be_eql([contribution.user.email])
    end

    context "when the project has a custom email" do
      let(:project){ Project.make! email_to_contributor: "Custom email" }
      let(:contribution){ Contribution.make! project: project }

      it "should send the custom email" do
        email = Notifier.thanks_for_contributing(contribution).deliver_now
        expect(email.body.to_s).to include(project.email_to_contributor)
      end
    end
  end

  describe ".thanks_for_signing" do
    let(:signature){ Signature.make! }

    it "should be sent to the signer" do
      email = Notifier.thanks_for_signing(signature).deliver_now
      expect(email.to).to be_eql([signature.user.email])
    end

    context "when the project has a custom email" do
      let(:project){ Project.make! email_to_signer: "Custom email" }
      let(:signature){ Signature.make! project: project }

      it "should send the custom email" do
        email = Notifier.thanks_for_signing(signature).deliver_now
        expect(email.body.to_s).to include(project.email_to_signer)
      end
    end
  end
end
