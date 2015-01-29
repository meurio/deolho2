class AddUserIdToSignature < ActiveRecord::Migration
  def change
    add_column :signatures, :user_id, :integer, null: false
    add_foreign_key :signatures, :users
  end
end
