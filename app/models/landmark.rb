class Landmark < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :user, :name, :location, :description, :price_per_day, presence: true
end
