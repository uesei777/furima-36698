class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :product, presence: true
  validates :explanation, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_id,
            numericality: { other_than: 1, message: "can't be blank" }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :days
end
