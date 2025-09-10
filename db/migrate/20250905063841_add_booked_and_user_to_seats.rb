class AddBookedAndUserToSeats < ActiveRecord::Migration[7.0]
  def change
    # only add columns if they do not exist
    unless column_exists?(:seats, :booked)
      add_column :seats, :booked, :boolean, default: false
    end

    unless column_exists?(:seats, :user_id)
      add_reference :seats, :user, foreign_key: true, null: true
    end
  end
end
