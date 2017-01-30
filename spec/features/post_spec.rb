require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user_id: user.id) }
  describe 'index' do
    before do
      login_as(user, :scope => :user)
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
      post1 = FactoryGirl.create(:post, user_id: user.id)
      post2 = FactoryGirl.create(:second_post, user_id: user.id)
      visit posts_path
      expect(page).to have_content(/Some Rationale|Some more content/)
    end

    it "has a scope so that only post creators can see their posts" do
      other_user = FactoryGirl.create(:non_auth_user)
      post1 = FactoryGirl.create(:post, user_id: user.id)
      post2 = FactoryGirl.create(:second_post, user_id: user.id)
      post_from_other_user = FactoryGirl.create(:post_from_other_user, user_id: other_user.id)
      visit posts_path
      expect(page).to have_content(/Some Rationale|Some more content/)
      expect(page).not_to have_content(/And Some more content/)
    end
    describe "new" do
      it "has a link from the homepage" do
        employee = Employee.create(email: "employee@example.com", first_name: "Employee", last_name: "Example",
                  password: "foobar", password_confirmation: "foobar", phone: "5555555555")
        login_as(employee, :scope => :user)
        visit root_path
        expect(page).to have_content('Request Overtime')
        click_link "new_post_from_nav"
        expect(page.status_code).to eq(200)
      end
    end
  end

  describe "delete" do
    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user_id: @user.id)
      login_as(@user, :scope => :user)
    end
    it "can be deleted" do
      visit posts_path
      click_link "delete_#{@post.id}"
      expect(page.status_code).to eq(200)
    end
  end

  describe "creation" do
    before do
      login_as(user, :scope => :user)
      visit new_post_path
    end
    it "has a new form that can be reached" do
      expect(page.status_code).to eq(200)
    end
    it "can be created from new form page" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Some rationale"
      fill_in 'post[daily_hours]', with: 9.0
      expect { click_on "Save" }.to change(Post, :count).by(1)
    end

    it "will have an user associated with the post" do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "user_association"
      fill_in 'post[daily_hours]', with: 8.0
      click_on "Save"

      expect(User.last.posts.last.rationale).to eq("user_association")
    end
  end

  describe "edit" do
    before do
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, user_id: @user.id)
      login_as(@user, :scope => :user)
    end
    it "can be reached by clicking edit on the index page" do
      visit posts_path
      click_link "edit_#{@post.id}"
      expect(page.status_code).to eq(200)
    end
    it "can be edited" do
      visit edit_post_path(@post)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Edited rationale"
      click_on "Save"
      expect(page).to have_content("Edited rationale")
    end

    it "cannot be edited by an unauthorized user" do
      logout(:user)
      non_auth_user = FactoryGirl.create(:non_auth_user)
      login_as(non_auth_user, :scope => :user)
      visit edit_post_path(@post)
      expect(current_path).to eq(root_path)
    end
  end
end
