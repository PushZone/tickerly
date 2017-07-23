class CreateCrimeUnapproves < ActiveRecord::Migration[4.2]
  def change
    create_table :crime_unapproves do |t|
      t.integer :user_id
      t.integer :crime_id
      t.string  :user_name
      t.timestamps
    end
  end
end
