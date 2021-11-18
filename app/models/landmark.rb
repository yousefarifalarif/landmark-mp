class Landmark < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  monetize :price_cents
  geocoded_by :name

  validates :user, :name, :location, :description, presence: true

  after_validation :geocode, if: :will_save_change_to_name?

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
