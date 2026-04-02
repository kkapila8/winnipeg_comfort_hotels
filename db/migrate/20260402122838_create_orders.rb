class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :province_id
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_postal
      t.string :province_name
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate
      t.decimal :subtotal
      t.decimal :gst_amount
      t.decimal :pst_amount
      t.decimal :hst_amount
      t.decimal :total
      t.string :status
      t.string :stripe_payment_id

      t.timestamps
    end
  end
end
