class AddGoogleDriveEmbedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :google_drive_embed, :string, null: false
  end
end
