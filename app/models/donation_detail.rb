class DonationDetail < ApplicationRecord
  belongs_to :user
  belongs_to :donation

  validates :metode, presence: true
  validates :value, presence: true
end
