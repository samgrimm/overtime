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
    it "requires a ssn" do
      @user.ssn = nil
      expect(@user).not_to be_valid
    end
    it "requires the ssn to only contain integers" do
      @user.phone = "great"
      expect(@user).not_to be_valid
    end

    it "requires the ssn to only have 4 chars" do
      @user.phone = "12345"
      expect(@user).not_to be_valid
    end
    it "requires a company" do
      @user.company = nil
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

  describe "relationship between admins and employees" do
    it "allows for admins to be associated with multiple employees" do
      employee_1 = FactoryGirl.create(:user)
      employee_2 = FactoryGirl.create(:user)
      admin = FactoryGirl.create(:admin)
      Hand.create!(user_id: admin.id, hand_id: employee_1.id)
      Hand.create!(user_id: admin.id, hand_id: employee_2.id)
      expect(admin.hands.count).to eq(2)
    end
  end
end
