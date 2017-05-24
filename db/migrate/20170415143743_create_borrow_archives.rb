class CreateBorrowArchives < ActiveRecord::Migration[5.0]
  def change
    create_table :borrow_archives do |t|
      t.references :book, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
