class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :post_code, null: false
      t.integer :prefecture_id, null: false
      t.string :street_address, null: false
      t.string :building_name, null: false
      t.string :telephone_number, null: false
      t.references :purchase, null: false,foreign_key: true

      t.timestamps
    end
  end
end
