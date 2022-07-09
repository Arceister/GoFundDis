require 'rails_helper'

RSpec.describe DonationDetail, type: :model do
  it "has a valid factory" do
    @user = create(:user)
    @donation = create(:donation)
    
    expect(build(:donation_detail, 
      user_id: @user.id, 
      donation_id: @donation.id)).to be_valid
  end
end
