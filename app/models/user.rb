class User < ApplicationRecord
  # Devise modules for authentication
  # Others available: :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :bookings, dependent: :destroy
  has_many :shows, through: :bookings
  has_many :seats, dependent: :nullify  # optional: if users can have booked seats directly

  # Validations
  validates :name, presence: true   # assuming you have a 'name' column
end
