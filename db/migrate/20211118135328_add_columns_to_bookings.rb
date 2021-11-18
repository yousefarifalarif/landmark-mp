class AddColumnsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :state, :string
    add_column :bookings, :checkout_session_id, :string
  end
end
