class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  with_options presence: true do
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :price
  end
end
