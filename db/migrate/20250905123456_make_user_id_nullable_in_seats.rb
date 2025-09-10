class MakeUserIdNullableInSeats < ActiveRecord::Migration[8.0]
  def change
    change_column_null :seats, :user_id, true
  end
end
