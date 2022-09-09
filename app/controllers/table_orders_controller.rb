class TableOrdersController < ApplicationController
  before_action :set_table_order, only: [:show, :edit, :update, :destroy]

  def index
    @table_orders = TableOrder.all
  end

  def show
  end

  def new
    @table_order = TableOrder.new
  end

  def create
    @table_order = TableOrder.new(table_order_params)
    @table_order.user = current_user
    if @table_order.save
      redirect_to table_order_path(@table_order)
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

  def table_order_params
    # Needs work
    params.require(:table_order).permit(:is_active)
  end
end
