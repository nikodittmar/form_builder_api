require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "is not valid with a username that has spaces" do
    expect(FactoryBot.build(:user, username: "I have spaces")).to_not be_valid
  end
  it "is not valid without a username" do
    expect(FactoryBot.build(:user, username: nil)).to_not be_valid
  end
  it "is not valid without an email" do
    expect(FactoryBot.build(:user, email: nil)).to_not be_valid
  end
  it "is not valid without a password" do
    expect(FactoryBot.build(:user, password: nil)).to_not be_valid
  end
  it "is not valid with an empty username" do
    expect(FactoryBot.build(:user, username: "")).to_not be_valid
  end
  it "is not valid with an empty email" do
    expect(FactoryBot.build(:user, email: "")).to_not be_valid
  end
  it "is not valid with an empty password" do
    expect(FactoryBot.build(:user, password: "")).to_not be_valid
  end
  it "is not valid with a username that is too long" do
    expect(FactoryBot.build(:user, username: Faker::Alphanumeric.alphanumeric(number: 31))).to_not be_valid
  end
  it "is not valid with a password that is too short" do
    expect(FactoryBot.build(:user, password: Faker::Alphanumeric.alphanumeric(number: 7))).to_not be_valid
  end
  it "is valid with a username that at the maximum length" do
    expect(FactoryBot.build(:user, username: Faker::Alphanumeric.alphanumeric(number: 30))).to be_valid
  end
  it "is valid with a username that at the minimum length" do
    expect(FactoryBot.build(:user, username: Faker::Alphanumeric.alphanumeric(number: 1))).to be_valid
  end
  it "is not valid with a password that is too short" do
    expect(FactoryBot.build(:user, password: Faker::Alphanumeric.alphanumeric(number: 7))).to_not be_valid
  end
  it "is valid with a password that at the minimum length" do
    expect(FactoryBot.build(:user, password: Faker::Alphanumeric.alphanumeric(number: 8))).to be_valid
  end
  it "is not valid with a non-unique username" do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, username: user.username)).to_not be_valid
  end
  it "is not valid with a non-unique email" do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: user.email)).to_not be_valid
  end
  it "is not valid with a not valid email" do
    expect(FactoryBot.build(:user, email: "not an email")).to_not be_valid
  end
  it "returns a token with the correct id" do
    user = FactoryBot.create(:user)
    token = user.token
    decoded_token = JWT.decode(token, Rails.application.secret_key_base)
    expect(decoded_token[0]['user_id']).to eq(user.id)
  end
end
