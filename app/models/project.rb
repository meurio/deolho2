class Project < ActiveRecord::Base
  has_many :signatures
  has_many :signers, through: :signatures, source: :user
  belongs_to :category
  belongs_to :organization

  validates :title, :abstract, :category, :organization, :google_drive_url, :google_drive_embed,
    presence: true
end
