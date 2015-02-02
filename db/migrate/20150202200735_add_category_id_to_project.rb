class AddCategoryIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :category_id, :integer, null: false
    add_foreign_key :projects, :categories
  end
end
