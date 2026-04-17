class Room < ApplicationRecord
  belongs_to :hotel
  has_many :room_categories, dependent: :destroy
  has_many :categories, through: :room_categories
  has_many :order_items
  has_one_attached :image

  ROOM_TYPES = %w[Standard Deluxe Suite Business].freeze

  validates :name,        presence: true
  validates :room_type,   presence: true, inclusion: { in: ROOM_TYPES }
  validates :price,       presence: true, numericality: { greater_than_or_equal_to: 0.01 }
  validates :capacity,    presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :sale_price,  numericality: { greater_than_or_equal_to: 0.01 }, allow_blank: true

  scope :available,        -> { where(available: true) }
  scope :on_sale,          -> { where(on_sale: true) }
  scope :new_arrivals,     -> { where(created_at: 3.days.ago..) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }
  scope :by_category,      ->(cat_id) { joins(:room_categories).where(room_categories: { category_id: cat_id }) }
  scope :search,           ->(keyword) { where('name LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%") }

  def current_price
    on_sale? && sale_price.present? ? sale_price : price
  end

  def discount_percent
    return nil unless on_sale? && sale_price.present?

    ((price - sale_price) / price * 100).round
  end

  def amenities_list
    amenities.to_s.split(',').map(&:strip)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[amenities available capacity created_at description
       hotel_id id name on_sale price room_type
       sale_price updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[hotel categories]
  end
end
