class Server < ApplicationRecord
  belongs_to :restaurant
  has_many :tables
end
