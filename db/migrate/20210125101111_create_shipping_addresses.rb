class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string  :postal_code  , null: false, default: ""
      t.integer :prefecture_id, null: false
      t.string  :municipality , null: false, default: ""
      t.string  :address      , null: false, default: ""
      t.string  :building_name             , default: ""
      t.string  :phone_number , null: false, default: ""
      t.references :product_purchase , null: false, foregin_key: true
      t.timestamps
    end
  end
end
