require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before do
      user = User.create(email: "email@test.com", password:"foobar", password_confirmation:"foobar", first_name: "jon", last_name:"Snow")
      @post = Post.create(date: Date.today, rationale:"Anything", user_id: user.id)
    end
    it "can be created" do
      expect(@post).to be_valid
    end
    it "cannot be created without a date and rationale" do
      @post.date = nil
      @post.rationale = nil
      expect(@post).not_to be_valid
    end
  end
end
