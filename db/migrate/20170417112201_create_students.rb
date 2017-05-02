class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.boolean :is_active
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
