class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :userid , :limit => 8
      t.string :useremail
      t.string :usergender
      t.string :userbirthday
      t.string :userpic
      t.timestamps null: false
    end
  end
end
