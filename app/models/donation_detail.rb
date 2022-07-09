class DonationDetail < ApplicationRecord
  belongs_to :user
  belongs_to :donation

  validates :metode, presence: true
end
