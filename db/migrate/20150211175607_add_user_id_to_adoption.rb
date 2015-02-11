class AddUserIdToAdoption < ActiveRecord::Migration
  def change
    add_column :adoptions, :user_id, :integer, null: false
  end
end
