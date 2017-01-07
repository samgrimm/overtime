require 'rails_helper'

describe 'navigate' do
  describe 'index' do
    before do
      @user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")
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
      post1 = Post.create(date: Date.today, rationale:"Post 1", user_id: @user.id)
      post2 = Post.create(date: Date.today, rationale:"Post 2", user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/Post 1|Post 2/)
    end
  end

  describe "creation" do
    before do
      user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")
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
