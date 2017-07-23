class CreateUserRouteHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :user_route_histories do |t|
      t.integer :user_id
      t.string :lat
      t.string :lon
      t.string :place
      t.timestamps
    end
  end
end
