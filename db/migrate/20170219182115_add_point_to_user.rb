class AddPointToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :point, :integer, default: 0
    add_column :crimes, :user_id, :integer
    add_column :crimes, :desc, :text
    add_column :crimes, :verified, :integer, default: 0
  end
end
