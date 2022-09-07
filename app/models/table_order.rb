class TableOrder < ApplicationRecord
  belongs_to :table
  belongs_to :users
  has_many :table_customers
end
