require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is valid with email, password, name, and phone" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end