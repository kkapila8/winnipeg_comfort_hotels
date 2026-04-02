class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.text :description

      t.timestamps
    end
  end
end
