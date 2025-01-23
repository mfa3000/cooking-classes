class CookingClass < ApplicationRecord
  belongs_to :user
  geocoded_by :address


  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  validates :title, :description, :price, :address, :date, :time, :capacity, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 0 }
  after_validation :geocode, if: :will_save_change_to_address?
end
