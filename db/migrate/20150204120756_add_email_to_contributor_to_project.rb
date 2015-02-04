class AddEmailToContributorToProject < ActiveRecord::Migration
  def change
    add_column :projects, :email_to_contributor, :text
  end
end
