class TableCustomersController < ApplicationController
  before_action :set_table_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:index, :show, :new, :create]
  before_action :set_table, only: [:index, :show, :new, :create]
  before_action :set_table_order, only: [:index, :show, :new, :create]

  def index
    @table_customers = TableCustomer.all
  end

  def show
  end

  def new
    @table_customer = TableCustomer.new
  end

  def create
    # Needs work
    @table_customer = TableCustomer.new(table_customer_params)
    @table_order.user = current_user
    @table_customer.table_order_id = @table_order.id

    @table_customer.table_order = @table_order

    if @table_customer.save
      redirect_to new_restaurant_table_table_order_table_customer_order_item_path(@restaurant, @table, @table_order, @table_customer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def split_evenly
    @table_order = TableOrder.find(params[:table_order_id])
    number = @table_order.table_customers.count
    splitted_bill = (@table_order.total_price / number).round(2)
    @table_order.table_customers.each do |customer|
      customer.update(amount_due: splitted_bill)
    end
  end

  def split_by_items

  end

  def pay_all

  end

  private

  def set_table_customer
    @table_customer = TableCustomer.find(params[:id])
  end

  def set_table_order
    @table_order = TableOrder.find(params[:table_order_id])
  end

  def set_table
    @table = Table.find(params[:table_id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def table_customer_params
    # Needs work
    params.require(:table_customer).permit(:name, :is_captain, :is_paid)
  end
end
