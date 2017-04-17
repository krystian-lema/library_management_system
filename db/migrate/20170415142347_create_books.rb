class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :edition
      t.date :publication_date
      t.string :ISBN
      t.string :signature
      t.references :library, foreign_key: true
      t.references :borrow, foreign_key: true
      t.references :borrow_archive, foreign_key: true

      t.timestamps
    end
  end
end
