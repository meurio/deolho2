class AddFacebookShareDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :facebook_share_description, :text
  end
end
