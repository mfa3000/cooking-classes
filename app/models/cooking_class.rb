class CookingClass < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  validates :title, :description, :price, :address, :date, :time, :capacity, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 0 }
end
