class CreateStoreDiscounts < ActiveRecord::Migration[4.2]
  def change
    create_table :store_discounts do |t|
      t.string  :name
      t.integer :store_id
      t.string  :discount
      t.integer :point
      t.string  :description
      t.integer :used
      t.timestamps
    end
  end
end
