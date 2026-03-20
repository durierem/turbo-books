class Lending < ApplicationRecord
  belongs_to :book

  validates :due_at, presence: true
  validates :address, presence: true
end
