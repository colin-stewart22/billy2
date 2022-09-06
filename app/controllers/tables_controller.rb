class TablesController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def index
    @tables = Table.all
  end

  def show
  end

  def new
    @table = Table.new
  end

  def create
    @table = Table.new(table_params)
    @table.user = current_user
    if @table.save
      redirect_to table_path(@table)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @table = Table.new
  end

  def update
    @table.update(table_params)
    redirect_to table_path(@table)
  end

  def destroy
    @table.destroy
    redirect_to tables_path, status: :see_other
  end

  private

  def set_table
    @table = table.find(params[:id])
  end

  def table_params
    params.require(:table).permit(:name, :address, :phone_number, :theme_color)
  end
end
