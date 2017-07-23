class CreateIplists < ActiveRecord::Migration[4.2]
  def change
    create_table :iplists do |t|
      t.string  :ip
      t.integer :count, default: 0
      t.string  :date
      t.timestamps
    end
  end
end
