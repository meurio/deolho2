class AddAbstractToProject < ActiveRecord::Migration
  def change
    add_column :projects, :abstract, :text
  end
end
