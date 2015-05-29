require 'rails_helper'

RSpec.describe GoogleAuthorization, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:access_token) }
  it { should validate_presence_of(:refresh_token) }
  it { should validate_presence_of(:issued_at) }
  it { should validate_presence_of(:expires_at) }
  it { should validate_uniqueness_of(:user_id) }

  describe "#expired?" do
    let(:user) { User.make! }
    context "when the authorization is expired" do
      subject { GoogleAuthorization.make! user: user, expires_at: 1.day.ago }
      
      it "should be truthy" do
        expect(subject.expired?).to be_truthy
      end
    end

    context "when the authorization is not expired" do
      subject { GoogleAuthorization.make! user: user, expires_at: 1.hour.from_now }

      it "should be falsy" do
        expect(subject.expired?).to be_falsy
      end
    end
  end
end
