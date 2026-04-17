class Category < ApplicationRecord
  has_many :room_categories, dependent: :destroy
  has_many :rooms, through: :room_categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
