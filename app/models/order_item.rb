class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :room

  validates :room_name,  presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :quantity,   presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :line_total, presence: true, numericality: { greater_than: 0 }
end