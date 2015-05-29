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

  after_create { self.delay.create_mailchimp_segment }
  after_update { self.delay.update_mailchimp_segment }
  before_validation :copy_google_drive_file, on: :create

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

  def create_mailchimp_segment
    segment = Gibbon::API.lists.segment_add(
      id: ENV["MAILCHIMP_LIST_ID"],
      opts: { type: "static", name: self.mailchimp_segment_name }
    )

    self.update_column :mailchimp_segment_uid, segment["id"]
  end

  def update_mailchimp_segment
    Gibbon::API.lists.segment_update(
      id: ENV["MAILCHIMP_LIST_ID"],
      seg_id: self.mailchimp_segment_uid,
      opts: { name: self.mailchimp_segment_name }
    )
  end

  def mailchimp_segment_name
    "LEG - #{self.id.to_s.rjust(4, "0")} - #{self.title}".byteslice(0..99)
  end

  def copy_google_drive_file
    # TODO: this api call should be performed in background
    file = GoogleDrive.copy_file(
      file_id: ENV["GOOGLE_DRIVE_FILE_ID"],
      title: self.title,
      access_token: self.user.google_authorization.access_token
    )

    self.google_drive_url = file.data["alternateLink"]
    self.google_drive_embed = "<iframe src=\"#{file.data["embedLink"]}\"></iframe>"

    # TODO: this api call should be performed in background
    GoogleDrive.insert_permission(
      file_id: file.data["id"],
      role: "reader",
      type: "anyone",
      additional_roles: ["commenter"],
      access_token: self.user.google_authorization.access_token
    )
  end
end
