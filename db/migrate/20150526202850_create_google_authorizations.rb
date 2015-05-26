class CreateGoogleAuthorizations < ActiveRecord::Migration
  def change
    create_table :google_authorizations do |t|
      t.integer :user_id
      t.string :access_token
      t.string :refresh_token
      t.datetime :issued_at
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
