class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :name, presence: true
  validates :phone, presence: true, uniqueness: true
  validates :birthdate, presence: true
end
