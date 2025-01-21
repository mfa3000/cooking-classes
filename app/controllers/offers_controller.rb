class OffersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_offer, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_to offer_path, notice: "Class successfully created."
    else
      render :new, alert: "There was an error creating the class."
    end
  end

  def destroy
    if @offer.destroy
      redirect_to offers_path, notice: "Offer successfully deleted."
    else
      redirect_to offers_path, alert: "Failed to delete the offer."
    end
  end

private

  def offer_params
    params.require(:offer).permit(:title, :description, :price, :address, :date, :time, :capacity)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def authorize_user
    unless @offer.user == current_user
      redirect_to offers_path, alert: "You are not authorized to delete this offer."
    end
  end
end
