require 'rails_helper'

RSpec.describe Adoption, :type => :model do
  it { should belong_to :user }
  it { should belong_to :project }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :project_id }
end
