class AddNewToCrime < ActiveRecord::Migration[4.2]
  def change
    add_column :crimes, :created_by, :string
    add_column :crimes, :crime_name, :string
    add_column :crimes, :crime_image_link, :string
  end
end
