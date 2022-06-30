class Donation < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :current, presence: true
  validates :need, presence: true
  validates :deadline, presence: true, comparison: {greater_than: DateTime.now}
end
