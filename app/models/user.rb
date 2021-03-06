class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, :last_name, :phone_number, presence: true
  has_many :bookings
  has_many :landmarks, dependent: :destroy
  has_one_attached :photo
end
