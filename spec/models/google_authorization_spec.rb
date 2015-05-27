require 'rails_helper'

RSpec.describe GoogleAuthorization, :type => :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:access_token) }
  it { should validate_presence_of(:refresh_token) }
  it { should validate_presence_of(:issued_at) }
  it { should validate_presence_of(:expires_at) }
  it { should validate_uniqueness_of(:user_id) }
end
