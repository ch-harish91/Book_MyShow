class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :show, null: false, foreign_key: true
      t.integer :seats_booked
      t.decimal :total_price

      t.timestamps
    end
  end
end
