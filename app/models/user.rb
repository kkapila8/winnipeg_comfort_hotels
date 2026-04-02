class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :province, optional: true
  has_many :orders, dependent: :destroy

  validates :name,  presence: true, length: { minimum: 2, maximum: 100 }
  validates :phone, format: { with: /\A[\d\s\-\+\(\)]+\z/, allow_blank: true }

  def full_address_present?
    address.present? && city.present? && postal_code.present? && province.present?
  end

  def display_name
    name.split.first
  end
end