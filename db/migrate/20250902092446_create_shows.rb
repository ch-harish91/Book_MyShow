class CreateShows < ActiveRecord::Migration[8.0]
  def change
    create_table :shows do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :theatre, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.decimal :ticket_price

      t.timestamps
    end
  end
end
