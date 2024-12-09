class AddShelfIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :books, :shelf, null: false, foreign_key: true
  end
end
