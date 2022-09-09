class TableCustomersController < ApplicationController

  def index
    @table_customers = TableCustomer.all
  end

  def show
    @table_customer = TableCustomer.find(params[:id])
  end

  def new
    @table_customer = TableOrder.new
  end

  def create
    # Needs work
    @table_customer = TableOrder.new(table_customer_params)
    @table_order = Table.find(params[:table_order_id])
    @table_customer.table_order_id = @table_order.id
    if @table_customer.save
      redirect_to table_customer_path(@table_customer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def table_customer_params
    # Needs work
    params.require(:table_customer).permit(:name, :is_captain, :is_paid)
  end
end
