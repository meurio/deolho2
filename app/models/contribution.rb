class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :project, presence: true
  validates :user_id, uniqueness: { scope: :project_id }

  after_create do
    SegmentSubscription.delay.create(
      user_id: self.user_id,
      segment_id: self.project.mailchimp_segment_uid
    )
  end
end
