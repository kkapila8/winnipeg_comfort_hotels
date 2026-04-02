class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.integer :hotel_id
      t.string :name
      t.string :room_type
      t.decimal :price
      t.decimal :sale_price
      t.integer :capacity
      t.text :description
      t.string :amenities
      t.boolean :available
      t.boolean :on_sale

      t.timestamps
    end
  end
end
