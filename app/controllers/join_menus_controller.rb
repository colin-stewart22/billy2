class JoinMenusController < ApplicationController
  def create

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

end
