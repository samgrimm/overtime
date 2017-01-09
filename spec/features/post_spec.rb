require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    before do
      @user = FactoryGirl.create(:user)
      login_as(@user, :scope => :user)

    end
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of Posts' do
      visit posts_path
      expect(page).to have_content("Posts")
    end

    it 'has a list of Posts' do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:second_post)
      visit posts_path
      expect(page).to have_content(/Some Rationale|Some more content/)
    end
  end

  describe "creation" do
    before do
      user = FactoryGirl.create(:user)
      login_as(user, :scope => :user)
      visit new_post_path
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      click_on "Save"
      expect(page).to have_content("Some rationale")
    end

    it "will have an user associated with the post" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "user_association"
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("user_association")
    end
  end
end
