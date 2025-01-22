class CookingClass < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  validates :title, :description, :price, :address, :date, :time, :capacity, presence: true
end
