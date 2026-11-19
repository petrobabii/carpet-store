class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :feedbacks, dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
