class MenuItem < ApplicationRecord
  has_many :join_menus
  has_many :menus, through: :join_menus

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :prepare_time, presence: true
end
