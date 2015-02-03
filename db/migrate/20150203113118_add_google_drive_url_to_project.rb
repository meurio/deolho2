class AddGoogleDriveUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :google_drive_url, :string, null: false
  end
end
