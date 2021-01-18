class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string     :name, null: false, default: ""
      t.text       :description, null: false
      t.integer    :category_id
      t.integer    :condition_id
      t.integer    :shipping_cost_id
      t.integer    :prefecture_id
      t.integer    :shipping_day_id
      t.integer    :price
      t.references :user, foregin_key: true
      t.timestamps
    end
  end
end
