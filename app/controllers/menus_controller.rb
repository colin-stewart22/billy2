class MenusController < ApplicationController
  before_action :set_restaurant, only: %i[index show new create edit update destroy]
  before_action :set_menu, only: %i[show edit update destroy]

  def index
    @menus = Menu.all
  end

  def show
    @join_menus = @menu.join_menus
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.restaurant = @restaurant
    if @menu.save
      redirect_to restaurant_menus_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # We might also need an edit method TBD
  end

  def update
    @menu.update(menu_params)
    redirect_to restaurant_menu_path(@restaurant, @menu)
  end

  def destroy
    @menu.destroy
    redirect_to restaurant_menus_path(@menu.restaurant), status: :see_other
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
