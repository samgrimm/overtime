require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    before do
      @user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")
    end
    it 'can be created' do
      expect(@user).to be_valid
    end

    it "cannot be created without first_name and last_name" do
      @user.first_name = nil
      @user.last_name = nil
      expect(@user).not_to be_valid
    end
  end
end
