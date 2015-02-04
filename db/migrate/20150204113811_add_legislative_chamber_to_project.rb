class AddLegislativeChamberToProject < ActiveRecord::Migration
  def change
    add_column :projects, :legislative_chamber, :string
  end
end
