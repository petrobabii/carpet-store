class Feedback < ApplicationRecord
  belongs_to :user

  validates :last_name, :first_name, :phone, :message, presence: true
end