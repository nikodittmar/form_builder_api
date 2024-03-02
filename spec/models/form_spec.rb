require 'rails_helper'

RSpec.describe Form, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.build(:form)).to be_valid
  end

  it "is not valid without a name" do
    expect(FactoryBot.build(:form, name: nil)).to_not be_valid
  end

  it "is not valid without an empty name" do
    expect(FactoryBot.build(:form, name: "")).to_not be_valid
  end
end
