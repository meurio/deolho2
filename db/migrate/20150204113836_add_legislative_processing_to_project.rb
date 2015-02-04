class AddLegislativeProcessingToProject < ActiveRecord::Migration
  def change
    add_column :projects, :legislative_processing, :text
  end
end
