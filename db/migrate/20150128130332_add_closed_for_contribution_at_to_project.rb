class AddClosedForContributionAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :closed_for_contribution_at, :datetime
  end
end
