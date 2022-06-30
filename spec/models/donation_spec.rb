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

  it "is invalid with empty current" do
    donation = build(:donation, current: nil)
    donation.valid?

    expect(donation.errors[:current]).to include("can't be blank")
  end

  it "is invalid with empty need" do
    donation = build(:donation, need: nil)
    donation.valid?

    expect(donation.errors[:need]).to include("can't be blank")
  end

  it "is invalid with empty deadline" do
    donation = build(:donation, deadline: nil)
    donation.valid?

    expect(donation.errors[:deadline]).to include("can't be blank")
  end
end
