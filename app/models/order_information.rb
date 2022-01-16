class OrderInformation
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :phone_number, numericality: {only_integer: true}, length: { in: 10..11 }
    validates :user_id, :item_id, :city, :address
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}


  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Information.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end