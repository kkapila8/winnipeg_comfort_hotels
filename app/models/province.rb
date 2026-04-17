class Province < ApplicationRecord
  has_many :users
  has_many :orders

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true, length: { maximum: 3 }
  validates :gst,  presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :pst,  presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hst,  presence: true, numericality: { greater_than_or_equal_to: 0 }

  def total_tax_rate
    gst + pst + hst
  end

  def tax_summary
    parts = []
    parts << "GST #{(gst * 100).round(1)}%" if gst.positive?
    parts << "PST #{(pst * 100).round(1)}%" if pst.positive?
    parts << "HST #{(hst * 100).round(1)}%" if hst.positive?
    parts.empty? ? 'No tax' : parts.join(' + ')
  end
end
