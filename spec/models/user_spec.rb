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

  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?

    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?

    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without phone number" do
    user = FactoryBot.build(:user, phone: nil)
    user.valid?

    expect(user.errors[:phone]).to include("can't be blank")
  end

  it "is invalid with duplicate phone" do
    user1 = FactoryBot.create(:user, phone: "081245678932")
    user2 = FactoryBot.build(:user, phone: "081245678932")
    
    user2.valid?
    expect(user2.errors[:phone]).to include("has already been taken")
  end

  it "is invalid without birthdate" do
    user = FactoryBot.build(:user, birthdate: nil)
    user.valid?

    expect(user.errors[:birthdate]).to include("can't be blank")
  end
end