class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :address, :building_name, :phone_number, :user_id, :product_id,
                :token

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :municipality
    validates :address
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/ }
    validates :token
    validates :user_id
    validates :product_id
  end
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    # 各テーブルにデータを保存する処理を書く
    product_purchase = ProductPurchase.create(user_id: user_id, product_id: product_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address,
                           building_name: building_name, phone_number: phone_number, product_purchase_id: product_purchase.id)
  end
end
