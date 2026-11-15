class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  STATUSES = ["В обробці", "Відправлено", "Виконано", "Скасовано"].freeze
  PAYMENT_STATUSES = ["Не оплачено", "Оплачено"].freeze
  DELIVERY_METHODS = ["Нова Пошта", "Укрпошта", "Самовивіз"].freeze
  PAYMENT_METHODS = ["Післяплата (при отриманні)", "Оплата карткою"].freeze

  before_validation :set_pickup_address

  validates :customer_name, :phone, :address, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :payment_status, inclusion: { in: PAYMENT_STATUSES }
  validates :delivery_method, inclusion: { in: DELIVERY_METHODS }
  validates :payment_method, inclusion: { in: PAYMENT_METHODS }

  private

  def set_pickup_address
    if delivery_method == "Самовивіз" && address.blank?
      self.address = "Самовивіз з магазину (вул. Незалежності, 123, Київ)"
    end
  end
end