class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menus
  has_many :menu_items
  has_many :tables
  has_many :table_orders, through: :tables
  has_many :table_customers, through: :table_orders
  has_many :order_items, through: :table_customers
  has_many :restaurant_servers
  has_many :users, through: :restaurant_servers

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :theme_color, presence: true
end
