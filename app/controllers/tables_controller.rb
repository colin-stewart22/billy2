class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, only: [:new, :create]
  def index
    @tables = Table.all
  end

  def show
    @qr_code = RQRCode::QRCode.new(@table.qr_code)
    @svg = @qr_code.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      standalone: true
    )
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    @table.restaurant = @restaurant
    if @table.save
      redirect_to restaurant_table_path(@restaurant, @table)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @table = Table.new
  end

  def update
    @table.update(table_params)
    # redirect_to table_path(@table)
  end

  def destroy
    @table.destroy
    # redirect_to tables_path, status: :see_other
  end

  private

  def set_table
    @table = Table.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def table_params
    params.require(:table).permit(:table_number, :qr_code)
  end
end
