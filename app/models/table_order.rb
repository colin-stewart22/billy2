class TableOrder < ApplicationRecord
  belongs_to :table
  belongs_to :user
  has_many :table_customers
end
