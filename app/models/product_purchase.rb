class ProductPurchase < ApplicationRecord
  has_one :shipping_address
  belongs_to :product
  belongs_to :user
end
