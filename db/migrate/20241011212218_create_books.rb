class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.belongs_to :author, index: true
      t.timestamps
    end
  end
end
