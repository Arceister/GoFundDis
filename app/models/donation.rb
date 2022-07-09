class Donation < ApplicationRecord
  has_many :donation_details
  has_many :users, through: :donation_details

  validates :title, presence: true, uniqueness: true
  validates :current, presence: true
  validates :need, presence: true
  validates :deadline, presence: true, comparison: {greater_than: DateTime.now}
end
