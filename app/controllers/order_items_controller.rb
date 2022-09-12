class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[update destroy prepared! served!]

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @table = Table.find(params[:table_id])
    @table_order = TableOrder.find(params[:table_order_id])
    @table_customers = @table_order.table_customers
    @table_customer = TableCustomer.find(params[:table_customer_id])
  end

  def show
    @table_customer = TableCustomer.find(params[:table_customer_id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = @restaurant.menus.select(&:is_active).first
    @table = Table.find(params[:table_id])
    @table_order = TableOrder.find(params[:table_order_id])
    @table_customer = TableCustomer.find(params[:table_customer_id])
    @order_item = OrderItem.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @table = Table.find(params[:table_id])
    @table_order = TableOrder.find(params[:table_order_id])
    @table_customer = TableCustomer.find(params[:table_customer_id])
    @menu_items = MenuItem.where(id: params.dig(:order_item, :menu_item_id))
    return render_new if @menu_items.empty?

    ActiveRecord::Base.transaction do
      @menu_items.each do |item|
        @order_item = OrderItem.new(order_item_params)
        @order_item.table_customer = @table_customer
        @order_item.menu_item = item
        @order_item.estimated_serving_time = item.prepare_time
        @order_item.save!
      end
      redirect_to restaurant_table_table_order_table_customer_path(
        @restaurant,
        @table,
        @table_order,
        @table_customer
      )
    end
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  def update
  end

  def destroy
    @order_item.destroy
    # redirect_to host_restaurant_path(@order_item.restaurant), status: :see_other
  end

  def prepared!
    @order_item.update(is_prepared: true)
    redirect_to kitchen_path(@order_item.restaurant)
  end

  def served!
    @order_item.update(is_served: true)
    redirect_to restaurant_table_table_orders_path(@order_item.restaurant, @order_item.table)
  end

  def bool_to_ready(value)
    "<span class='bg-red-500 px-3 py-2 text-white text-sm rounded-lg'>Ready</span>".html_safe if value
  end

  private

  def order_item_params
    params.require(:order_item).permit(:note, menu_item_ids: [])
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def render_new
    @order_item = OrderItem.new
    render :new, status: :unprocessable_entity
  end
end
