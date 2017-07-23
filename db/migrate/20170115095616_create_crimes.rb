class CreateCrimes < ActiveRecord::Migration[4.2]
  def change
    create_table :crimes do |t|
    	  t.string :user_name
      	t.string :crime_type
        t.string :user_email
      	t.string :lat
      	t.string :lon
      	t.string :location_name
      	t.timestamps
    end
  end
end
