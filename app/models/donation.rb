class Donation < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :current, presence: true
  validates :need, presence: true
end
