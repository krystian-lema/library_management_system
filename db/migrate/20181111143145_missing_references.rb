class MissingReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :borrows, :library, foreign_key: true
    add_reference :borrows, :borrow, foreign_key: true
    add_reference :borrows, :borrow_archive, foreign_key: true
    add_reference :borrow_archives, :student, foreign_key: true
    add_reference :borrows, :student, foreign_key: true
  end
end
