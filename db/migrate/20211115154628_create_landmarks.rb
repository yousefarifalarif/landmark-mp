class CreateLandmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :landmarks do |t|
      t.string :name
      t.string :location
      t.text :description
      t.decimal :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
