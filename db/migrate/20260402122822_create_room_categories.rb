class CreateRoomCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :room_categories do |t|
      t.integer :room_id
      t.integer :category_id

      t.timestamps
    end
  end
end
