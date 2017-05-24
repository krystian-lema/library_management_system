class DeleteReferencesFromBooks < ActiveRecord::Migration[5.0]
  def change
  	remove_column :books, :borrow_id
  	remove_column :books, :borrow_archive_id
  end
end
