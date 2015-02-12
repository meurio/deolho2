class AddImageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :image, :string, null: false
  end
end
