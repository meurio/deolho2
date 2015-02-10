class Project < ActiveRecord::Base
  has_many :signatures
  has_many :signers, through: :signatures, source: :user
  has_many :contributions
  has_many :contributors, through: :contributions, source: :user
  belongs_to :category
  belongs_to :organization

  validates :title, :abstract, :category, :organization, :google_drive_url, :google_drive_embed,
    presence: true

  mount_uploader :facebook_share_image, FacebookShareImageUploader

  scope :open_for_contribution, -> { where("closes_for_contribution_at > ?", Time.now) }
end
