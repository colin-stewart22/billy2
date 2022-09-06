class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :menu_items
  has_many :tables

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :theme_color, presence: true
end
