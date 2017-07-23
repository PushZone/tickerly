class CreateUserActivities < ActiveRecord::Migration[4.2]
  def change
    create_table :user_activities do |t|
      t.integer :user_id
      t.integer :crime_id
      t.integer :activity_type
      t.integer :point
      t.string :crime_type
      t.string :lat
      t.string :lon
      t.string :location_name

      t.timestamps
    end
  end
end
