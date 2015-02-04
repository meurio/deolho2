class AddFacebookShareTitleToProject < ActiveRecord::Migration
  def change
    add_column :projects, :facebook_share_title, :string
  end
end
