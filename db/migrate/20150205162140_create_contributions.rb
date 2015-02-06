class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :user_id, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end

    add_foreign_key :contributions, :projects
  end
end
