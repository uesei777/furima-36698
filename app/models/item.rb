class Item < ApplicationRecord

  belongs_to :user
  has_one_attached :image

  validates :product, presence: true
  validates :explanation, presence: true
  validates :price, presence: true, numericality: { in: 300..9999999 }

  validates :category, :status, :delivery_fee, :prefecture, :days, numericality: { other_than: 1 , message: "can't be blank"}

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :days

end
