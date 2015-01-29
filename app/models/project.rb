class Project < ActiveRecord::Base
  has_many :signatures
  has_many :signers, through: :signatures, source: :user

  def closed_for_contribution?
    self.closed_for_contribution_at.present?
  end

  def close_for_contribution
    self.update_attribute :closed_for_contribution_at, Time.now
  end

  def reopen_for_contribution
    self.update_attribute :closed_for_contribution_at, nil
  end
end
