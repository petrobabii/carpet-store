class Carpet < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :order_items, dependent: :restrict_with_error
  has_many :reviews, dependent: :destroy

  def average_rating
    return 0.0 if reviews.empty?
    reviews.average(:rating).to_f.round(1)
  end

  def reviews_count
    reviews.size
  end
end