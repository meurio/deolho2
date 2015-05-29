class GoogleAuthorization < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :access_token, :refresh_token, :issued_at, :expires_at, presence: true
  validates :user_id, uniqueness: true

  def expired?
    self.expires_at <= Time.current
  end
end
