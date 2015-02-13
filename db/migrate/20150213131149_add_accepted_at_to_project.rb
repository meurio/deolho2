class AddAcceptedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :accepted_at, :datetime
  end
end
