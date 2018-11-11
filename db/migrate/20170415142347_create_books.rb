class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :edition
      t.date :publication_date
      t.string :ISBN
      t.string :signature

      t.timestamps
    end
  end
end
