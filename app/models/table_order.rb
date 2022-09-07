class TableOrder < ApplicationRecord
  belongs_to :table
  belongs_to :users
end
