class AddTwitterShareMessageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :twitter_share_message, :text
  end
end
