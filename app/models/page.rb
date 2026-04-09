class Page < ApplicationRecord
  validates :slug,    presence: true, uniqueness: true, inclusion: { in: %w[about contact] }
  validates :title,   presence: true
  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "slug", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end