class AddCoordinatesToLandmarks < ActiveRecord::Migration[6.1]
  def change
    add_column :landmarks, :latitude, :float
    add_column :landmarks, :longitude, :float
  end
end
