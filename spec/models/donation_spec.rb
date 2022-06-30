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

  it "is invalid with duplicate title" do
    donation1 = create(:donation, title: "Bantu Jagad Beli PS4!")
    donation2 = build(:donation, title: "Bantu Jagad Beli PS4!")
    donation2.valid?

    expect(donation2.errors[:title]).to include("has already been taken")
  end
end
