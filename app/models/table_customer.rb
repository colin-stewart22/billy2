class TableCustomer < ApplicationRecord
  has_many :order_items

  validates :name, presence: true
end
