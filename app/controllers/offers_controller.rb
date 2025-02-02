class OffersController < ApplicationController
  before_action only: [:new, :create]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_to offers_path, notice: "Class successfully created."
    else
      flash.now[:alert] = "There was an error creating the class."
      render :new
    end
  end

private

  def offer_params
    params.require(:offer).permit(:title, :description, :price, :address, :date, :time, :capacity)
  end
end
