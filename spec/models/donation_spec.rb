require 'rails_helper'

RSpec.describe Donation, type: :model do
  it "has a valid factory" do
    expect(build(:donation)).to be_valid
  end

  it "is invalid without title" do
    donation = build(:donation, title: nil)
    donation.valid?

    expect(donation.errors[:title]).to include("can't be blank")
  end
end
