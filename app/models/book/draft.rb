class Book::Draft < ApplicationRecord
  STEPS = 1..3

  validates :step, presence: true, inclusion: { in: STEPS }

  with_options(on: :step_1) do |draft|
    draft.validates :name, presence: true
  end

  with_options(on: :step_2) do |draft|
    draft.validates :name, presence: true
    draft.validates :author_id, presence: true
  end

  with_options(on: :step_3) do |draft|
    draft.validates :name, presence: true
    draft.validates :author_id, presence: true
  end

  def completed?
    step == STEPS.last
  end

  def next_step
    step + 1
  end

  def book
    Book.new(name:, author_id:, shelf_id:)
  end
end
