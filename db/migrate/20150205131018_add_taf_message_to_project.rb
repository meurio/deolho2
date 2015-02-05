class AddTafMessageToProject < ActiveRecord::Migration
  def change
    add_column :projects, :taf_message, :text
  end
end
