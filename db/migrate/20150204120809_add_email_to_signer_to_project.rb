class AddEmailToSignerToProject < ActiveRecord::Migration
  def change
    add_column :projects, :email_to_signer, :text
  end
end
