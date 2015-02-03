require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should have_many :signatures }
  it { should have_many :signers }
  it { should belong_to :category }
  it { should belong_to :organization }
  it { should validate_presence_of :title }
  it { should validate_presence_of :abstract }
  it { should validate_presence_of :category }
  it { should validate_presence_of :organization }
  it { should validate_presence_of :google_drive_url }
  it { should validate_presence_of :google_drive_embed }
end
