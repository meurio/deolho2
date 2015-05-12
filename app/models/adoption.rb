class Adoption < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  validates :user, :project, presence: true
  validates :user_id, uniqueness: { scope: :project_id }

  after_create { self.delay.create_segment_subscription }

  def create_segment_subscription
    HTTParty.post(
      "#{ENV["ACCOUNTS_HOST"]}/users/#{self.user_id}/segment_subscriptions.json",
      body: {
        token: ENV["ACCOUNTS_API_TOKEN"],
        segment_subscription: { segment_id: self.project.mailchimp_segment_uid }
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
