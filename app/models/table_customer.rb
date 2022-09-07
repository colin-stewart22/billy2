class TableCustomer < ApplicationRecord
  has_many :order_items
  belongs_to :table_order

  validates :name, presence: true
end
