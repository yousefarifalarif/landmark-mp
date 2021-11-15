class Landmark < ApplicationRecord
  belongs_to :user

  validates :user, :name, :location, :description, :price_per_day, presence: true
end
