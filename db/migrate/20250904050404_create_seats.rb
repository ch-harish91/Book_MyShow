class CreateSeats < ActiveRecord::Migration[8.0]
  def change
    create_table :seats do |t|
      t.references :show, null: false, foreign_key: true
      t.string :seat_number
      t.string :status

      t.timestamps
    end
  end
end
