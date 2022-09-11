class TableOrdersController < ApplicationController
  before_action :set_table_order, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:new, :create]
  before_action :set_table, only: [:new, :create]
  def index
    @table_orders = TableOrder.all
  end

  def show
    # @qr_code = RQRCode::QRCode.new(@table.qr_code)
    # @svg = @qr_code.as_svg(
    #   offset: 0,
    #   color: '000',
    #   shape_rendering: 'crispEdges',
    #   standalone: true,
    #   module_size: 2
    # )
  end

  def new
    @table_order = TableOrder.new
  end

  def create
    @table_order = TableOrder.new(table_order_params)
    @table_order.user = current_user
    @table_order.restaurant = @restaurant
    @table_order.table = @table
    if @table_order.save
      redirect_to new_restaurant_table_table_order_table_customer_path(@restaurant, @table, @table_order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @table_order = TableOrder.new
  end

  def update
    @table_order.update(table_order_params)
    redirect_to table_order_path(@table_order)
  end

  def destroy
    @table_order.destroy
    redirect_to table_orders_path, status: :see_other
  end

  private

  def set_table_order
    @table_order = TableOrder.find(params[:id])
  end

  def set_table
    @table = Table.find(params[:table_id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def table_order_params
    # Needs work
    params.require(:table_order).permit(:is_active)
  end
end
