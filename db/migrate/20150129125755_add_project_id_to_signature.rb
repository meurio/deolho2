class AddProjectIdToSignature < ActiveRecord::Migration
  def change
    add_column :signatures, :project_id, :integer, null: false
    add_foreign_key :signatures, :projects
  end
end
