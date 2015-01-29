require 'rails_helper'

RSpec.describe User, :type => :model do
  describe "#signed?" do
    subject { User.make! }
    let(:project) { Project.make! }

    context "When the user have signed the given project" do
      before { Signature.make! project: project, user: subject }

      it "Should be truthy" do
        expect(subject.signed?(project)).to be_truthy
      end
    end

    context "When the user haven't signed the given project" do
      it "Should be falsey" do
        expect(subject.signed?(project)).to be_falsey
      end
    end
  end
end
