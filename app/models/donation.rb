class Donation < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
