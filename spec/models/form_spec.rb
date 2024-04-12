require 'rails_helper'
require 'examples.rb'

RSpec.describe Form, type: :model do
  it "is valid with valid attributes" do
    expect(FactoryBot.build(:form)).to be_valid
  end

  it "is invalid with invalid attributes" do
    expect(FactoryBot.build(:form, components: INVALID_COMPONENTS)).to_not be_valid
  end
end
