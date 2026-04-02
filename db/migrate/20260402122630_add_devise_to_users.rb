class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name,               null: false, default: ""
      t.string :phone
      t.string :address
      t.string :city
      t.string :postal_code
      t.integer :province_id
      t.boolean :admin,             default: false

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end