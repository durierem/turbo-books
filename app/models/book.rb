class Book < ApplicationRecord
  validates :name, presence: true

  belongs_to :author

  scope :by_name, ->(search) { where("name LIKE?", "%#{search}%") }
end
