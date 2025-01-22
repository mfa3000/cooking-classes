class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :cooking_class

  validates :user_id, uniqueness: { scope: :cooking_class_id, message: "You have already booked this class" }
end
