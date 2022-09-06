class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[new create update destroy]

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    # if @order_item.save
    #   redirect_to new_restaurant_menu_path(@restaurant)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def destroy
    @order_item.destroy
    # redirect_to host_restaurant_path(@order_item.restaurant), status: :see_other
  end

  private

  def order_item_params
    params.require(:order_item).permit(:created_time, :estimated_serving_time, :is_served)
  end

  def set_order_item
    @menu_item = MenuItem.find(params[:id])
  end
end
