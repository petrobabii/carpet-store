class Review < ApplicationRecord
  belongs_to :user
  belongs_to :carpet

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: { message: "обов'язковий, якщо оцінка 2 зірки або нижче" }, if: -> { rating.present? && rating <= 2 }
  validates :user_id, uniqueness: { scope: :carpet_id, message: "ви вже залишили відгук на цей товар" }
end