require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with email, password, name, and phone" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with duplicate email" do
    user1 = FactoryBot.create(:user, email: "email@email.com")
    user2 = FactoryBot.build(:user, email: "email@email.com")
    
    user2.valid?
    expect(user2.errors[:email]).to include("has already been taken")
  end
end