class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true, inclusion: { in: 0..5 }, numericality: true
  validates :comment, presence: true
end
