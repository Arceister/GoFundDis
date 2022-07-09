class User < ApplicationRecord
  has_many :donation_details
  has_many :donations, through: :donation_details

  has_many :donations

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :birthdate, presence: true
end
