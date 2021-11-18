class AddPriceToBookings < ActiveRecord::Migration[6.1]
  def change
    add_monetize :bookings, :amount, currency: { present: false }
  end
end
