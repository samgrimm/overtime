require 'rails_helper'

describe 'AuditLog Feature' do

  describe "index" do
    before do
      admin = FactoryGirl.create(:admin)
      login_as(admin, :scope => :user)
      FactoryGirl.create(:audit_log)
    end
    it "has an index page that can be reached" do
      visit audit_logs_path
      expect(page.status_code).to eq(200)
    end
    it "renders audit log content" do
      visit audit_logs_path
      expect(page).to have_content("SNOW, JON")
    end
    it "cannot be acccessed by non-admin users" do
      logout(:admin)
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit audit_logs_path
      expect(current_path).to eq(root_path)
    end
  end
end
