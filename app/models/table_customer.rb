class TableCustomer < ApplicationRecord
  has_many :order_items
  has_many :table_orders

  validates :name, presence: true
end
