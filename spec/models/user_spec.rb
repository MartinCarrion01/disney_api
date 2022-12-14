require 'rails_helper'

RSpec.describe User, type: :model do
  it "must have a password of length greater than 8" do
    user = FactoryBot.create(:user, password: "123456", password_confirmation: "123456")
    expect(user).to eq("marton1")
  end
end
