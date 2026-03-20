class CreateLendings < ActiveRecord::Migration[7.2]
  def change
    create_table :lendings do |t|
      t.references :book, null: false, foreign_key: true
      t.string :address, null: false
      t.datetime :due_at, null: false
      t.json :notes, default: []

      t.timestamps
    end
  end
end
