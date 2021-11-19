class AddAddressToLandmarks < ActiveRecord::Migration[6.1]
  def change
    add_column :landmarks, :address, :string
  end
end
