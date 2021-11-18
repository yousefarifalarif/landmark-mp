class Booking < ApplicationRecord
  belongs_to :landmark
  belongs_to :user
  has_one :review
  # validates :start_date, :end_date, presence: true, availability: true
  validate :end_date_after_start_date
  monetize :price_cents

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    errors.add(:end_date, "must be after the start date") if start_date > end_date
  end
end
