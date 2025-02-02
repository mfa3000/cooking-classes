class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cooking_classes, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_classes, through: :bookings, source: :cooking_class
end
