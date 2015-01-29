class AddUserIdToSignature < ActiveRecord::Migration
  def change
    add_column :signatures, :user_id, :integer, null: false
  end
end
