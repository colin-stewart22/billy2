class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[new edit update destroy]

  def index
    # We might need this not sure yet
  end

  def show
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    # if @menu.save
    #   redirect_to new_restaurant_menu_path(@restaurant)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit
    # We might also need an edit method TBD
  end

  def update
    @menu_item.update(menu_item_params)
    # redirect_to new_restaurant_menu_path(@restaurant)
  end

  def destroy
    @menu_item.destroy
    # redirect_to host_restaurant_path(@menu.restaurant), status: :see_other
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :category, :price, :prepare_time)
  end

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end