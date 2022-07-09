require 'rails_helper'

RSpec.describe DonationDetail, type: :model do
  it "has a valid factory" do
    @user = create(:user)
    @donation = create(:donation, user_id: @user.id)

    expect(build(:donation_detail, 
      user_id: @user.id, 
      donation_id: @donation.id)).to be_valid
  end

  it "is invalid without user id" do
    @user = create(:user)
    @donation = create(:donation, user_id: @user.id)

    @donation_detail = build(:donation_detail, donation_id: @donation.id)
    @donation_detail.valid?

    expect(@donation_detail.errors[:user]).to include("must exist")
  end

  it "is invalid without donation id" do
    @user = create(:user)
    @donation = create(:donation, user_id: @user.id)

    @donation_detail = build(:donation_detail, user_id: @user.id)
    @donation_detail.valid?

    expect(@donation_detail.errors[:donation]).to include("must exist")
  end

  it "is invalid without metode" do
    @user = create(:user)
    @donation = create(:donation, user_id: @user.id)

    @donation_detail = build(:donation_detail, 
      user_id: @user.id,
      donation_id: @donation.id,
      metode: nil)
    @donation_detail.valid?

    expect(@donation_detail.errors[:metode]).to include("can't be blank")
  end
end
