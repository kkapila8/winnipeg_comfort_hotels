class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :order_items, dependent: :destroy

  STATUSES = %w[pending paid shipped].freeze

  validates :shipping_address, presence: true
  validates :shipping_city,    presence: true
  validates :shipping_postal,  presence: true
  validates :province_name,    presence: true
  validates :subtotal,  presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total,     presence: true, numericality: { greater_than: 0 }
  validates :status,    presence: true, inclusion: { in: STATUSES }

  def tax_total
    gst_amount + pst_amount + hst_amount
  end
end