class AddProjectIdToAdoption < ActiveRecord::Migration
  def change
    add_column :adoptions, :project_id, :integer, null: false
    add_foreign_key :adoptions, :projects
  end
end
