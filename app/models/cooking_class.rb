class CookingClass < ApplicationRecord
  belongs_to :user

  validates :title, :description, :price, :address, :date, :time, :capacity, presence: true
end
