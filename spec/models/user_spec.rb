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
  it "is valid with a username that at the maximum length" do
    expect(FactoryBot.build(:user, username: Faker::Alphanumeric.alphanumeric(number: 30))).to be_valid
  end
  it "is valid with a username that at the minimum length" do
    expect(FactoryBot.build(:user, username: Faker::Alphanumeric.alphanumeric(number: 1))).to be_valid
  end
  it "is not valid with a password that is too short" do
    expect(FactoryBot.build(:user, password: Faker::Internet.password(min_length: 7, max_length: 7, mix_case: true))).to_not be_valid
  end
  it "is valid with a password that at the minimum length" do
    expect(FactoryBot.build(:user, password: Faker::Internet.password(min_length: 8, max_length: 8, mix_case: true))).to be_valid
  end
  it "is not valid with a password not containing an uppercase letter" do
    expect(FactoryBot.build(:user, password: "nouppercasel3tters")).to_not be_valid
  end
  it "is not valid with a password not containing a lowercase letter" do
    expect(FactoryBot.build(:user, password: "NOLOWERCASEL3TTERS")).to_not be_valid
  end
  it "is not valid with a password not containing a digit" do
    expect(FactoryBot.build(:user, password: "NoDigitsPassword")).to_not be_valid
  end
  it "is valid with a valid password" do
    expect(FactoryBot.build(:user, password: "ValidPassword123")).to be_valid
  end
  it "is not valid with a non-unique username" do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, username: user.username)).to_not be_valid
  end
  it "is not valid with a non-unique email" do
    user = FactoryBot.create(:user)
    expect(FactoryBot.build(:user, email: user.email)).to_not be_valid
  end
  it "username uniquness constraint is case insensitive" do
    user = FactoryBot.create(:user, username: 'username')
    expect(FactoryBot.build(:user, username: 'Username')).to_not be_valid
  end
  it "email uniqueness constraint is case insensitive" do
    user = FactoryBot.create(:user, email: 'example@domain.com')
    expect(FactoryBot.build(:user, email: 'Example@domain.com')).to_not be_valid
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
  it "destroys all accociated forms" do
    user = FactoryBot.create(:user)
    form = FactoryBot.create(:form, user: user)
    user.destroy
    expect { Form.find(form.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
