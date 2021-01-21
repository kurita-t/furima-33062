class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, length: {minimum: 1, maximum: 40 }
    validates :description, length: {minimum: 1, maximum: 1000 }
    validates :price
  end
  validates :price, numericality: { only_integer: true,  greater_than: 299, less_than: 9999999}

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 }

end
