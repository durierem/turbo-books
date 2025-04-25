class Book < ApplicationRecord
  validates :name, presence: true

  belongs_to :author

  scope :by_name, ->(term) { where("name LIKE ?", ["%", term, "%"].join)  }
end
