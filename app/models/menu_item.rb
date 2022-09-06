class MenuItem < ApplicationRecord
  has_many :join_menus
  has_many :menus, through: :join_menus
end
