require 'rails_helper'

RSpec.describe Form, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.build(:form)).to be_valid
  end
end
