class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :name, :description, :price, presence: true
  validates :price, numericality: { only_integer: true,  greater_than: 300, less_than: 9999999}

  #ジャンルの選択が「--」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 }

end
