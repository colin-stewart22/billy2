class TableCustomersController < ApplicationController
  before_action :set_table_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:index, :show, :new, :create, :split_evenly, :split_by_items]
  before_action :set_table, only: [:index, :show, :new, :create, :checkout, :split_evenly, :split_by_items]
  before_action :set_table_order, only: [:index, :show, :new, :create, :checkout, :split_evenly, :split_by_items]

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
    @table_order.user = User.where(is_owner: false).sample
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
    @table_order.update(payment_option: "split_evenly")
    redirect_to restaurant_table_table_order_table_customers_path(@restaurant, @table, @table_order)
  end

  def split_by_items
    @table_order = TableOrder.find(params[:table_order_id])
    @table_order.update(payment_option: "split_by_items")
    redirect_to restaurant_table_table_order_table_customers_path(@restaurant, @table, @table_order)
  end

  def pay_all
  end

  def checkout
    @restaurant = Restaurant.find(params[:id])
    @table_customer = TableCustomer.find(params[:table_customer_id])
    # order  = Order.create!(teddy: teddy, teddy_sku: teddy.sku, amount: teddy.price, state: 'pending', user: current_user)
    table_price = @table_customer.amount_due.to_f

    # @table_customer.order_items.each do |order|
    #   table_price += order.menu_item.price
    # end
    @restaurant = @table_customer.table_order.restaurant
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: table_price.to_i * 100,
          product_data: {
            name: 'T-shirt',
            description: 'Comfortable cotton t-shirt',
            images: ['https://example.com/t-shirt.png']
          }
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "http://127.0.0.1:3000/restaurants/#{@restaurant.id}/tables/#{@table.id}/table_orders/#{@table_order.id}/table_customers/#{@table_customer.id}/confirmation",
      cancel_url: "http://127.0.0.1:3000/restaurants/#{@restaurant.id}/tables/#{@table.id}/table_orders/#{@table_order.id}/table_customers/#{@table_customer.id}/checkout",
    )

    @table_customer.update(checkout_session_id: session.id)
    # redirect_to checkout_path(@restaurant, @table, @table_order)
  end

  def confirmation
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
