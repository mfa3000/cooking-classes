class CookingClassesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :book]
  before_action :set_cooking_class, only: [:show, :destroy, :book, :cancel_booking, :edit]
  before_action :authorize_user, only: [:destroy, :edit]

  def index
    @cooking_classes = CookingClass.all
    if params[:query].present?
    @cooking_classes = CookingClass.search_by_title_and_description(params[:query])
    end
    if params[:start_date].present? && params[:end_date].present?
      @cooking_classes = @cooking_classes.where(date: params[:start_date]..params[:end_date])
    end
  end

  def show
    @user = "currentUser"
    total_participants = @cooking_class.bookings.sum(:participants) # Sum the participants from bookings
    @available_spots = @cooking_class.capacity - total_participants
  end

  def new
    @cooking_class = CookingClass.new
  end

  def create
    @cooking_class = current_user.cooking_classes.build(cooking_class_params)
    if @cooking_class.save
      redirect_to cooking_classes_path, notice: "Class successfully created."
    else
      render :new, alert: "There was an error creating the class."
    end
  end

  def destroy
    if @cooking_class.destroy
      redirect_to request.referer&.include?(my_cooking_classes_path) ? my_cooking_classes_path : cooking_classes_path,
        notice: "Class successfully deleted."
    else
      redirect_to cooking_classes_path, alert: "Failed to delete the class."
    end
  end

  def update
    @cooking_class = CookingClass.find(params[:id])
    if @cooking_class.update(cooking_class_params)
      redirect_to @cooking_class
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end
  def book
    participants = params[:participants].to_i

    if @cooking_class.capacity >= participants
      booking = current_user.bookings.new(cooking_class: @cooking_class, participants: participants)
      if booking.save
        @cooking_class.update(capacity: @cooking_class.capacity - participants)
        redirect_to bookings_path, notice: "Class successfully booked for #{participants} participants."
      else
        redirect_to cooking_class_path(@cooking_class), alert: "You have already booked this class."
      end
    else
      redirect_to cooking_class_path(@cooking_class), alert: "This class is fully booked and cannot be reserved."
    end
  end

  def cancel_booking
    booking = current_user.bookings.find_by(cooking_class: @cooking_class)
    if booking
      participants = booking.participants
      booking.destroy
      @cooking_class.update(capacity: @cooking_class.capacity + participants)
      redirect_to cooking_class_path(@cooking_class), notice: "Your booking has been canceled."
    else
      redirect_to cooking_class_path(@cooking_class), alert: "You haven't booked this class."
    end
  end

  def my_cooking_classes
    @cooking_classes = current_user.cooking_classes
  end

private

  def cooking_class_params
    params.require(:cooking_class).permit(:title, :description, :price, :address, :date, :time, :capacity, :category)
  end

  def set_cooking_class
    @cooking_class = CookingClass.find(params[:id])
  end

  def authorize_user
    @cooking_class = CookingClass.find(params[:id])
    unless @cooking_class.user == current_user
      redirect_to cooking_classes_path, alert: "You are not authorized to delete this class."
    end
  end
end
