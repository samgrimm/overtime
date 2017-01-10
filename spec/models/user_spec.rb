require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it 'can be created' do
      expect(@user).to be_valid
    end
  end

  describe "validations" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "cannot be created without first_name " do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end
    it "cannot be created without last_name" do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it "cannot be created without a phone" do
      @user.phone = nil
      expect(@user).not_to be_valid
    end

    it "requires the phone number to only contain integers" do
      @user.phone = "mygreatstr"
      expect(@user).not_to be_valid
    end

    it "requires the phone number to only have 10 chars" do
      @user.phone = "12345678901"
      expect(@user).not_to be_valid
    end
  end


  describe "custom name methods" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it "has a full name method that combines first and last name" do
      expect(@user.full_name).to eq('SNOW, JON')
    end
  end
end
