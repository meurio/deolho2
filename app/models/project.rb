class Project < ActiveRecord::Base
  has_many :signatures
  has_many :signers, through: :signatures, source: :user
  has_many :contributions
  has_many :contributors, through: :contributions, source: :user
  has_many :adoptions
  has_many :adopters, through: :adoptions, source: :user
  belongs_to :category
  belongs_to :organization
  belongs_to :user

  validates :title, :abstract, :category, :organization, :google_drive_url, :google_drive_embed, :user,
    presence: true

  mount_uploader :facebook_share_image, FacebookShareImageUploader

  scope :open_for_contribution, -> { where("closes_for_contribution_at > ?", Time.now) }
  scope :processing_in_legislative, -> { where("legislative_processing <> ''") }

  def open_for_contribution?
    closes_for_contribution_at > Time.now
  end

  def processing_in_legislative?
    legislative_processing.present?
  end

  def adopted?
    adopters.any?
  end
end
