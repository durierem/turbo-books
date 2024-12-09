class CreateBookDrafts < ActiveRecord::Migration[7.2]
  def change
    create_table :book_drafts do |t|
      t.integer :step
      t.string :name
      t.bigint :author_id
      t.bigint :shelf_id
      t.timestamps
    end
  end
end
