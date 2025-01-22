class CookingClassesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :set_cooking_class, only: [:destroy]
  before_action :authorize_user, only: [:destroy]

  def index
    @cooking_classes = CookingClass.all
  end

  def show
    @cooking_class = CookingClass.find(params[:id])
    @user = "currentUser"
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
      redirect_to cooking_classes_path, notice: "Class successfully deleted."
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
    @cooking_class = CookingClass.find(params[:id])
  end

private

  def cooking_class_params
    params.require(:cooking_class).permit(:title, :description, :price, :address, :date, :time, :capacity)
  end

  def set_cooking_class
    @cooking_class = CookingClass.find(params[:id])
  end

  def authorize_user
    unless @cooking_class.user == current_user
      redirect_to cooking_classes_path, alert: "You are not authorized to delete this class."
    end
  end


end
