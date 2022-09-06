class OrderItem < ApplicationRecord
  belongs_to :menu_item
  belongs_to :table_customer

  validates :created_time, presence: true
  validates :estimated_serving_time, presence: true
end
