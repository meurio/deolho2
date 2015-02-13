require 'rails_helper'

RSpec.describe Signature, :type => :model do
  before { Signature.make! }

  it { should belong_to :user }
  it { should belong_to :project }
  it { should validate_presence_of :user }
  it { should validate_presence_of :project }
  it { should validate_uniqueness_of(:user_id).scoped_to(:project_id) }
end
