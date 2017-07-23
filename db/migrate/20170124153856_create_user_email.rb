class CreateUserEmail < ActiveRecord::Migration[4.2]
  def change
    create_table :useremails do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :password
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :userid 
      t.string :useremail
      t.string :usergender
      t.string :userbirthday
      t.string :userpic
      t.string :password
      t.timestamps null: false
    end
  end
end
