class CreateUserItems < ActiveRecord::Migration[4.2]
  def change
    create_table :user_items do |t|
      t.integer :user_id
      t.integer :store_discount_id
      t.boolean :used, default: false
      t.timestamps
    end
  end
end
