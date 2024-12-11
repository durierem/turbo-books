class Book::Draft < ApplicationRecord
  STEPS = 1..3

  validates :step, presence: true, inclusion: { in: STEPS }

  with_options(on: :step_1) do |draft|
    draft.validates :step, comparison: { equal_to: 1 }
    draft.validates :name, presence: true
  end

  with_options(on: :step_2) do |draft|
    draft.validates :step, comparison: { equal_to: 2 }
    draft.validates :name, presence: true
    draft.validates :author_id, presence: true
  end

  with_options(on: :step_3) do |draft|
    draft.validates :step, comparison: { equal_to: 3 }
    draft.validates :name, presence: true
    draft.validates :author_id, presence: true
    draft.validates :shelf_id, presence: true
  end

  def completed?
    step == STEPS.last
  end

  def next_step
    valid?(:"step_#{step}") ? step + 1 : step
  end

  def book
    Book.new(name:, author_id:, shelf_id:)
  end
end
