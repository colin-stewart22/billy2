class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :table_customer
end
