class MenuItem < ApplicationRecord
  has_many :join_menus
  has_many :menus, through: :join_menus
  belongs_to :restaurant

  validates :name, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :prepare_time, presence: true

  # Max characters for description is 100
  validates :description, length: { maximum: 1000 }
end
