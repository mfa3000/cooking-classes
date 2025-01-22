class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookings = current_user.bookings.includes(:cooking_class)
  end

  def create
    @cooking_class = CookingClass.find(params[:cooking_class_id])

  @booking = Booking.new(
    user_id: current_user.id,
    cooking_class_id: @cooking_class.id
  )

    if @booking.save
      redirect_to bookings_path, notice: "Your booking has been confirmed!"
    end
  end
end
