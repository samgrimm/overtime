require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    before do
      @user = FactoryGirl.create(:user)
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

  describe "custom name methods" do
    before do
      @user = FactoryGirl.create(:user)
    end
    it "has a full name method that combines first and last name" do
      expect(@user.full_name).to eq('SNOW, JON')
    end
  end
end
