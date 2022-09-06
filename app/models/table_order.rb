class TableOrder < ApplicationRecord
  belongs_to :table_customer
  belongs_to :table
  belongs_to :user

  # validates :group_url, presence: true
end
