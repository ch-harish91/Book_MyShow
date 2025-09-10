class CreateTheatres < ActiveRecord::Migration[8.0]
  def change
    create_table :theatres do |t|
      t.string :name
      t.string :location
      t.integer :total_seats

      t.timestamps
    end
  end
end
