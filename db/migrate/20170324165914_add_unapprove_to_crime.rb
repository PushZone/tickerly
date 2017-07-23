class AddUnapproveToCrime < ActiveRecord::Migration[4.2]
  def change
    add_column :crimes, :unapprove, :integer, default: 0
  end
end
