class Project < ActiveRecord::Base
  def closed_for_contribution?
    self.closed_for_contribution_at.present?
  end

  def close_for_contribution
    self.update_attribute :closed_for_contribution_at, Time.now
  end
end
