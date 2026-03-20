# Example of form class
# It doesn't have to be organised like this, this is only an example
# It's pure Ruby & ActiveModel::Model

class LendingForm
  include ActiveModel::Model
  include Rails.application.routes.url_helpers

  DELIVERY_MODES = %w[DELIVERY PICK_UP]

  DELIVERY_PICK_UP_LOCATIONS = {
    "Location 1" => "1106 Giraffe Hill Drive",
    "Location 2" => "4780 Green Acres Road",
    "Location 3" => "4913 Peaceful Lane",
    "Location 4" => "814 Werninger Street"
  }

  OPS = {
    add_note: ->(lending_form, _) { lending_form.notes << '' },
    remove_note: ->(lending_form, index) { lending_form.notes.delete_at(index.to_i) }
  }

  attr_accessor :author_id
  attr_accessor :book_id
  attr_accessor :delivery_address
  attr_accessor :delivery_mode
  attr_accessor :delivery_pick_up_location
  attr_accessor :notes
  attr_accessor :due_at
  attr_accessor :lending

  validates :book_id, presence: true
  validates :delivery_address, presence: true
  validates :notes, length: { minimum: 1 }

  def self.from(lending)
    delivery_mode = lending.address.in?(LendingForm::DELIVERY_PICK_UP_LOCATIONS.values) ? 'PICK_UP' : 'DELIVERY'
    
    new(
      author_id: lending.book.author.id,
      book_id: lending.book.id,
      delivery_address: lending.address,
      delivery_mode: delivery_mode,
      delivery_pick_up_location: delivery_mode == 'PICK_UP' ? LendingForm::DELIVERY_PICK_UP_LOCATIONS.find { |_, address| address == lending.address }.first : nil,
      notes: lending.notes,
      due_at: lending.due_at,
      lending: lending
    )
  end

  def initialize(...)
    super(...)
    @delivery_mode ||= 'DELIVERY'
    if @delivery_mode == 'PICK_UP'
      @delivery_pick_up_location ||= 'Location 1'
      @delivery_address = DELIVERY_PICK_UP_LOCATIONS[@delivery_pick_up_location]
    end
    @notes ||= []
    @due_at ||= Time.current + 15.days
  end

  def authors
    Author.all
  end

  def author
    return nil if author_id.blank?

    authors.find_by(id: author_id)
  end

  def books
    return [] if author.blank?

    author.books
  end

  def book
    return nil if book_id.blank?

    books.find_by(id: book_id)
  end

  def delivery_address
    if @delivery_mode == 'PICK_UP'
      DELIVERY_PICK_UP_LOCATIONS[@delivery_pick_up_location] || DELIVERY_PICK_UP_LOCATIONS.values.first
    else
      @delivery_address
    end
  end

  def lending
    @lending ||= Lending.new(book_id:, address: delivery_address, due_at:, notes:)
  end

  def save
    return false unless valid?

    # could be a service or more complex stuff
    if lending.persisted?
      lending.update(book_id:, address: delivery_address, due_at:, notes:)
    else
      lending.save
    end
  end

  def submit_url
    lending.persisted? ? url_for([ lending, only_path: true ]) : url_for([ :lendings, only_path: true ])
  end

  def submit_method
    lending.persisted? ? :patch : :post
  end

  def url
    lending.persisted? ? url_for([ :edit, lending, only_path: true ]) : url_for([ :new, :lending, only_path: true ])
  end
end
