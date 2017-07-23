class CreateStores < ActiveRecord::Migration[4.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :lat
      t.string :lon
      t.string :description
      t.timestamps
    end
  end
end
