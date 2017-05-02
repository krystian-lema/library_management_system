class AddColumnToBorrows < ActiveRecord::Migration[5.0]
  def change
  	add_column :borrows, :status, :integer, after: :book_id
  end
end
