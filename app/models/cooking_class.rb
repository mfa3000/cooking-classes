class CookingClass < ApplicationRecord
  belongs_to :user
  geocoded_by :address


  has_many :bookings, dependent: :destroy
  has_many :booked_users, through: :bookings, source: :user

  validates :title, :description, :price, :address, :date, :time, :capacity, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 0 }
  after_validation :geocode, if: :will_save_change_to_address?


  include PgSearch::Model

  pg_search_scope :search_by_title_and_description,
    against: [ :title, :description ],
    using: {
      tsearch: { prefix: true }
    }
CATEGORIES = ["Mexican", "Japanese", "Italian", "Thai", "Street Food", "Indian", "French", "Other"]

validates :category, inclusion: { in: CATEGORIES, message: "%{value} is not a valid category" }


end
