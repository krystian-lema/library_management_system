class CreateIdCards < ActiveRecord::Migration[5.0]
  def change
    create_table :id_cards do |t|
      t.integer :number
      t.belongs_to :student, foreign_key: true

      t.timestamps
    end
  end
end
