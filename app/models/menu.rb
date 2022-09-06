class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :join_menus
  has_many :menu_items, through: :join_menus
end
