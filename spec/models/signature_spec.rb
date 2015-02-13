require 'rails_helper'

RSpec.describe Signature, :type => :model do
  it { should belong_to :user }
  it { should belong_to :project }
  it { should validate_presence_of :user }
  it { should validate_presence_of :project }
end
