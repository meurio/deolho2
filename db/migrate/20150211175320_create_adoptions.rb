class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|

      t.timestamps
    end
  end
end
