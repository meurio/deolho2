class AddFacebookShareImageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :facebook_share_image, :string
  end
end
