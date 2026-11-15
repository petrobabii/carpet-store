class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :carpet

  def subtotal
    price * quantity
  end
end