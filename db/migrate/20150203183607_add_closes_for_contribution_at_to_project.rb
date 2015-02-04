class AddClosesForContributionAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :closes_for_contribution_at, :datetime, null: false
  end
end
