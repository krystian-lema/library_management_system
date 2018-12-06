class MissingBooksReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :library, foreign_key: true
    add_reference :books, :borrow, foreign_key: true
    add_reference :books, :borrow_archive, foreign_key: true
  end
end
