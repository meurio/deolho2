class RemoveClosedForContributionAtFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :closed_for_contribution_at, :datetime
  end
end
