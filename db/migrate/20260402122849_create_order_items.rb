class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :room_id
      t.string :room_name
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :line_total

      t.timestamps
    end
  end
end
