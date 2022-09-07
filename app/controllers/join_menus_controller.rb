class JoinMenusController < ApplicationController
  before_action :set_menu, only: %i[new create edit update]
  def new
    @join_menu = JoinMenu.new
  end

  def create
    @menu_items = MenuItem.where(id: params.dig(:join_menu, :menu_items))
    return render_new if @menu_items.empty?

    ActiveRecord::Base.transaction do
      @menu_items.each do |item|
        join_menu = JoinMenu.new(menu: @menu, menu_item: item)
        join_menu.save!
      end
      redirect_to
    end
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def joinmenu_params
    params.require(:join_menu).permit(menu_item_ids: [])
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def render_new
    @join_menu = JoinMenu.new
    @join_menu.errors.add(:base, "It already exists")
    render :new, status: :unprocessable_entity
  end
end
