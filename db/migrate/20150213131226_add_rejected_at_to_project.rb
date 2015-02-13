class AddRejectedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :rejected_at, :datetime
  end
end
