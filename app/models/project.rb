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
    :image, presence: true

  mount_uploader :facebook_share_image, FacebookShareImageUploader
  mount_uploader :image, ThumbUploader

  def open?
    closes_for_contribution_at > Time.now
  end

  def processing?
    legislative_processing.present?
  end

  def adopted?
    adoptions.any?
  end

  def accepted?
    !self.accepted_at.nil?
  end

  def rejected?
    !self.rejected_at.nil?
  end

  def finished?
    accepted? || rejected?
  end

  def status
    if finished?
      "finished"
    elsif processing?
      "processing"
    elsif adopted?
      "adopted"
    elsif open?
      "open"
    end
  end
end
