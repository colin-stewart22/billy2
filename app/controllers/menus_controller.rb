class MenusController < ApplicationController
  before_action :set_restaurant, only: %i[new create edit updates]
  before_action :set_menu, only: %i[edit update destroy]

  def index
    @menus = Menus.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.restaurant = @restaurant
    # if @menu.save
    #   redirect_to new_restaurant_menu_path(@restaurant)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    # We might also need an edit method TBD
  end

  def update
    @menu.update(menu_params)
    # redirect_to new_restaurant_menu_path(@restaurant)
  end

  def destroy
    @menu.destroy
    # redirect_to host_restaurant_path(@menu.restaurant), status: :see_other
  end

  private

  def menu_params
    params.require(:menu).permit(:name)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
