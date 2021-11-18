class AddPriceToLandmarks < ActiveRecord::Migration[6.1]
  def change
    add_monetize :landmarks, :price, currency: { present: false }
  end
end
