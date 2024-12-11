class Book < ApplicationRecord
  validates :name, presence: true

  belongs_to :author
  belongs_to :shelf
end
